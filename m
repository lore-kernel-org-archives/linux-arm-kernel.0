From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Nov 2011 21:51:29 +0100
Subject: [PATCH] at91: at91-ohci: fix set/get power
In-Reply-To: <CAFumwP08OeGqrNrTAzYeLkB=oZtyMDEoBa9epoHcG_Wjc5CQ8g@mail.gmail.com>
References: <1321112773-8360-1-git-send-email-plagnioj@jcrosoft.com>
 <CAFumwP08OeGqrNrTAzYeLkB=oZtyMDEoBa9epoHcG_Wjc5CQ8g@mail.gmail.com>
Message-ID: <20111114215129.783f4ab3@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Mon, 14 Nov 2011 22:39:21 +0200,
Andrew Victor <avictor.za@gmail.com> a ?crit :

> Shouldn't that rather be:
>    if (!gpio_is_valid(pdata->vbus_pin[port]))
>           return;

No, because gpio_is_valid() accept 0 as a valid GPIO. Therefore, when
you don't set anything for the .vbus_pin field, the values are zero,
and gpio_is_valid() will tell you that it's a valid GPIO. If we wanted
to use gpio_is_valid(), we would have to do something like .vbus_pin =
{ -EINVAL, -EINVAL } in every board for which the vbus pin isn't used.
It's a quite unfortunate behaviour of the current gpio subsystem.

Regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
