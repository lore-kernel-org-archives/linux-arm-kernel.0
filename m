From: eric.miao@linaro.org (Eric Miao)
Date: Tue, 1 Mar 2011 11:06:07 +0800
Subject: [PATCH V3 4/4] mmc: sdhci-esdhc: enable esdhc on imx53
In-Reply-To: <010C9052C42A00499CE76D637FA5EE900C7B7B@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1298892725-23672-1-git-send-email-Hong-Xing.Zhu@freescale.com>
	<1298892725-23672-4-git-send-email-Hong-Xing.Zhu@freescale.com>
	<20110228144741.GF15532@pengutronix.de>
	<010C9052C42A00499CE76D637FA5EE900C7B7B@039-SN1MPN1-001.039d.mgd.msft.net>
Message-ID: <AANLkTinabUZ8wot=iu7Yp6LnmVWu_k1Ha2srHaipy0qx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Hmm, to me, just using cpu_is_mx53() is more readable than introducing
>> another layer of flags/quirks.
> Hi Wolfram:
> I discussed it with Richard Zhao before sending out these V3 patches.
> As we know that there is not only mx53 has this issue, maybe some following SOCs have this issue too.
> So we make a decision that we introduce another flags/quirks to declare it for all those SOCs that required this
> mechanism in the end.

I agree with Richard here that a flag/quirk will be more generic than
cpu_is_*(). Otherwise we may end up one day growing a big list of
these cpu_is_*().

One other point to consider is the SoC stepping, as this might be
fixed in later steppings, and keeping cpu_is_mx53() or
cpu_is_mx53_stepping_b2_or_above() doesn't look very good in
the driver code itself.
