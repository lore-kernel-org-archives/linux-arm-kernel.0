From: avictor.za@gmail.com (Andrew Victor)
Date: Mon, 14 Nov 2011 22:39:21 +0200
Subject: [PATCH] at91: at91-ohci: fix set/get power
In-Reply-To: <1321112773-8360-1-git-send-email-plagnioj@jcrosoft.com>
References: <1321112773-8360-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <CAFumwP08OeGqrNrTAzYeLkB=oZtyMDEoBa9epoHcG_Wjc5CQ8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

> in commit aa6e52a35 we introduce the support of overcurrent notification
> but the set and get of the power without checking if the gpio is valid or not

> + ? ? ? if (pdata->vbus_pin[port] <= 0)
> + ? ? ? ? ? ? ? return;

Shouldn't that rather be:
   if (!gpio_is_valid(pdata->vbus_pin[port]))
          return;


Regards,
  Andrew Victor
