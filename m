From: b32955@freescale.com (Huang Shijie)
Date: Fri, 20 Jan 2012 11:29:25 +0800
Subject: [PATCH 00/10] patch set about the MXS-DMA
In-Reply-To: <20120119094513.GB2630@pengutronix.de>
References: <1326953767-24155-1-git-send-email-b32955@freescale.com>
 <20120119091034.GH2247@S2101-09.ap.freescale.net>
 <20120119094513.GB2630@pengutronix.de>
Message-ID: <4F18DF95.80700@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>>> [2] patch 6 ~ patch 10: rewrite the last parameter of mxs_dma_prep_slave_sg().
>> For the sake of bitsec, at least patches #7 and #8 need to be one patch.
>> That said, if I apply the series and then check out the commit at patch
>> #7, you need to all mxs-dma client drivers, mxs-mmc, gpmi do not break.
> I'd say patch 6-10 should be squashed, simply. My personal preference is
> to change #9 to simply read the register when needed and do not expand
It's better to add a new field. i also want to add a new field
`bch_version`, because different
BCH version may support different ECC strength. For example, some
version BCH can support to 24 bit,
while the latest BCH may support to 40 bit. So the BCH version may
limits the computing of ECC strength.

Best Regards
Huang Shijie

> the struct, but this is a minor thing.
>
> Regards,
>
>    Wolfram
>
