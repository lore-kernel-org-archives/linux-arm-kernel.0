From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 17 Dec 2013 14:07:34 +0800
Subject: [PATCH v3 0/7] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA56B3A@DBDE04.ent.ti.com>
References: <1387184330-14448-1-git-send-email-b32955@freescale.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA56ADC@DBDE04.ent.ti.com>
 <20131217040209.GA27091@shlinux2.ap.freescale.net>
 <20980858CB6D3A4BAE95CA194937D5E73EA56B3A@DBDE04.ent.ti.com>
Message-ID: <20131217060731.GJ6691@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 05:00:53AM +0000, Gupta, Pekon wrote:
> >From: Huang Shijie [mailto:b32955 at freescale.com]
> >On Tue, Dec 17, 2013 at 04:08:33AM +0000, Gupta, Pekon wrote:
> >>
> >> As much base code is copied from m25p90.c,
> >> Do you mind keeping the sign-offs of the original contributors of m25p80.c
> >> at-least in patches where much code is ported ?
> >I have added the lines in the spi-nor.c:
> >
> > " Cloned most of the code from the m25p80.c"
> >
> >> This would at-least give some credit to original authors and contributors.
> >I do not change any authors information of m25p80.c.
> >
> >If it is not enough?  Could you remind me what to do ?

In case you clone most of the code from m25p80.c, you need to keep the
copyright of that file as well, and add yours on top of it.

> >
> (1) Add sign-offs of main authors of m25p80, so that original contributors
>  still remains in path of submission [1].

The sign-off shouldn't be added by anyone than the person himself.  The
sign-off tag is generally used in the following cases as far as I know.

1. When the patch is authored, the author A should surely add his
   sign-off in the first place.

2. If person B submits A's patch with some or without any change on the
   patch, B should add his sign-off.

3. Maintainer C should add his sign-off when he applies the patch.

In any case, one's sign-off shouldn't be added anyone but himself.
I do not see the need to add sign-off of m25p80 authors at the current
situation.

> 
> (2) Also, please remove following from spi-nor.c
>   However, you can keep this in fsl-quadspi.c.
>   +MODULE_AUTHOR("Freescale Semiconductor Inc.");
>   I'm sure this was _not_ present in original m25p80.c
>  (m25p80.c was started as ST's driver as per MODULE_DESCRIPTION)

Are you talking about drivers/mtd/devices/m25p80.c?  If so, I'm seeing
the following lines in the file.

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Mike Lavender");
MODULE_DESCRIPTION("MTD SPI driver for ST M25Pxx flash chips");

I think we should keep the original MODULE_LICENSE and MODULE_AUTHOR,
add a new MODULE_AUTHOR("Huang Shijie <b32955@freescale.com>") line,
and update MODULE_DESCRIPTION line properly.

> 
> (3)     +MODULE_LICENSE("GPL");
> Also, I assume the license version should be "GPLv2" ?

If this is from original m25p80.c, we shouldn't change it, IMO.

> 
> Request you please _not_ to tag generic driver frameworks with any
> specific company names, and let open-source be independent of any
> commercial company tags.

Are you sure about that?  Run git grep "redhat" on folder kernel\ and
see what you get.

> Otherwise eventually everything generic driver
> will have some or other company name associated with it.

What's the problem of that?  People are paid to do generic work, and why
shouldn't their employer's name be mentioned to give the credit.  As
long as the copyright is GPL, the code can be used, modified and
distributed freely, and I do not see any problem with having company
name in there.

Shawn

> And this should be followed by everyone (include myself).
> 
> I'm not sure why maintainers are not objecting to this. David, Brian ??
> 
> 
> [1] https://www.kernel.org/doc/Documentation/SubmittingPatches
> "12) Sign your work"
> 
> 
> with regards, pekon
