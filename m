From: david.lanzendoerfer@o2s.ch (David =?ISO-8859-1?Q?Lanzend=F6rfer?=)
Date: Sun, 15 Dec 2013 20:35:17 +0100
Subject: [linux-sunxi] Re: [PATCH 1/5] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
In-Reply-To: <52ADF7D8.2010900@redhat.com>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com>
 <20131215162109.GI3651@lukather> <52ADF7D8.2010900@redhat.com>
Message-ID: <2378731.6b9MyH8v8A@dizzy-6.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

> >>>> [...]
> >>>> +	mmc->f_max		= 50000000;
> >>>> [...]
> >> [...]
> >> in case of sdc3 they are putting 200000000 in f_max (as that is often
> >> used for sdio cards) but then later in set_ios they clamp the passed
> >> in clock to 47000000 Mhz, so I seriously doubt that 200Mhz has actually
> >> worked. Hence I've simply gone for a safe range for now. If someone has
> >> cards capable of doing 200 MHz we could certainly run various tests and
> >> try to improve this, but for now this seems a sane range to start with.
> > That's probably something that you should mention in your comment then :)
> Good point, David ?
Yes.
a) We should mention any reason why we did what.
b) If there is room for optimization we should mention that as well since:
	i) we won't remember every single detail in half a year
	ii) someone else might need to follow our considerations

> Right, my bad, sorry. I was so happy I was finally ready to send the patch
> upstream (I finally had fixed everything on my todo list), I rushed the
> cover letter a bit. I was planning on putting things like this in there,
> as well as why we didn't try to extend the mmc-dw driver, but I forgot.
Do you have something like this in mind? -> drivers/mmc/host/dw_mmc-exynos.c
Might actually be working if it actually is the same IDMAC controller.

cheers
David
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131215/31695d5c/attachment.sig>
