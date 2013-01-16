From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 16 Jan 2013 08:48:34 +0000
Subject: [PATCH 03/18] power: ab8500_charger: Detect charger removal
In-Reply-To: <20130116013640.GA11105@lizard.fhda.edu>
References: <1357909986-9262-1-git-send-email-lee.jones@linaro.org>
 <1357909986-9262-4-git-send-email-lee.jones@linaro.org>
 <20130116013640.GA11105@lizard.fhda.edu>
Message-ID: <20130116084834.GF9379@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Jan 2013, Anton Vorontsov wrote:

> On Fri, Jan 11, 2013 at 01:12:51PM +0000, Lee Jones wrote:
> > Add two new work queues to provide USB and AC charger disconnect
> > detection.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> [....]
> > +		if ((statval & usbch)) != usbch)
> 
>   CC      drivers/power/ab8500_charger.o
> drivers/power/ab8500_charger.c: In function ?ab8500_charger_usb_attached_work?:
> drivers/power/ab8500_charger.c:1812:26: error: expected expression before ?!=? token
> drivers/power/ab8500_charger.c:1812:34: error: expected statement before ?)? token
> drivers/power/ab8500_charger.c: In function ?ab8500_charger_ac_attached_work?:
> drivers/power/ab8500_charger.c:1852:27: error: expected expression before ?!=? token
> drivers/power/ab8500_charger.c:1852:36: error: expected statement before ?)? token
> 
> I fixed it up...

You're a star.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
