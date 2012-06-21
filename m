From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 21 Jun 2012 10:05:34 +0800
Subject: [PATCH] ARM: mxs: store mac address read from OTP in device tree
In-Reply-To: <20120620053649.GG10387@shlinux2.ap.freescale.net>
References: <1340119246-17471-1-git-send-email-shawn.guo@linaro.org>
 <20120620053649.GG10387@shlinux2.ap.freescale.net>
Message-ID: <20120621020531.GA3971@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 01:36:50PM +0800, Dong Aisheng wrote:
> > +static void __init update_fec_mac_prop(enum mac_oui oui)
> So this is a general function, right?

No.  The function is only meant to provide an equivalent of
mx28evk_fec_get_mac and m28evk_fec_get_mac for mx28evk and m28evk
to boot from device tree.

> > +
> > +		oldmac = of_find_property(np, newmac->name, NULL);
> > +		if (oldmac)
> > +			prom_update_property(np, newmac, oldmac);
> > +		else
> > +			prom_add_property(np, newmac);
> Grant gave a suggestion before that we'd better change prom_update_property
> behavior to add_or_update from update only.
> I did a patch like that, with the patch the code here will become more simple.
> I will send it out in this thread for you to see if it helps.
> 
Yes, it helps.  Will have my patch rebased on yours once your patch
gets accepted.

-- 
Regards,
Shawn
