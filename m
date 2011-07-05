From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 5 Jul 2011 13:54:55 +0200
Subject: [PATCH 1/3] ohci-at91: add vbus_pin_inverted platform attribute
In-Reply-To: <4E12F7E6.7080604@mvista.com>
References: <1309856728-8265-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<4E12F7E6.7080604@mvista.com>
Message-ID: <20110705135455.5fa643cc@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 05 Jul 2011 15:39:18 +0400,
Sergei Shtylyov <sshtylyov@mvista.com> a ?crit :

> > -			gpio_direction_output(pdata->vbus_pin[i], 0);
> > +			gpio_direction_output(pdata->vbus_pin[i], 0 ^ pdata->vbus_pin_inverted);
> 
>     Why not simply 'pdata->vbus_pin_inverted'?

> > -			gpio_direction_output(pdata->vbus_pin[i], 1);
> > +			gpio_direction_output(pdata->vbus_pin[i], 1 ^ pdata->vbus_pin_inverted);
> 
>     Why not simply '!pdata->vbus_pin_inverted'?

Ah, correct. The 0 and 1 were present before, and I just wanted to xor
them with vbus_pin_inverted, but obviously, there's a simpler way of
writing things, as you suggest.

I'll update my patch and send a new version after gathering comments
from other reviewers.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
