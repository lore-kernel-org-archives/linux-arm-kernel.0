From: philippe.retornaz@gmail.com (=?ISO-8859-1?Q?Philippe_R=E9tornaz?=)
Date: Fri, 23 May 2014 08:50:54 +0200
Subject: [PATCH] ARM: imx: introduce function imx_free_mx3_camera
In-Reply-To: <20140522181024.GA20155@pengutronix.de>
References: <1400781080-6117-1-git-send-email-emilgoode@gmail.com>
 <20140522181024.GA20155@pengutronix.de>
Message-ID: <537EEFCE.8000201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe

Le 22/05/2014 20:10, Uwe Kleine-K?nig a ?crit :
[...]
> Today all imx machines should get their devices from an oftree, so
> the various functions to add devices started to bitrot. Moreover
> there is no reason to remove a device once it was successfully
> added.
>
> Note that platform_device_register_full has the same problem (i.e.
> pdev->dev.dma_mask isn't freed when the last reference to a device
> is dropped.) You'd do a better deed if you picked up
> http://thread.gmane.org/gmane.linux.kernel/1613364/focus=1635995
> instead of fixing dead code.

I would like to object that all imx machine should now boot from devicetree.
mx31moboard is still used and still get its kernel updated.
It has never booted from devicetree, and IIRC the "deal" when devicetree
was enforced on ARM was that all previous boards where still supported
and would not get removed.
So please don't kick us out of the kernel so fast :)

Thanks !

Philippe
