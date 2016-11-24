From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Nov 2016 11:59:58 +0100
Subject: [RFC PATCH 0/5] arm64: Allwinner H5 support
In-Reply-To: <1479950235-26821-1-git-send-email-andre.przywara@arm.com>
References: <1479950235-26821-1-git-send-email-andre.przywara@arm.com>
Message-ID: <20161124105958.xzp4fr2fs4p42upx@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2016 at 01:17:10AM +0000, Andre Przywara wrote:
> This series adds support for the recently released Allwinner H5 SoC [1] and
> the Orange Pi PC 2 board [2].
> This exercise is rather easy this time, since the new SoC is very similar
> to the existing H3 SoC and can thus share a lot of support.
> To express this, the first patch splits the H3 .dtsi to allow reusing
> it later. The last two patches add the H5 .dtsi and the .dts for the
> first available board featuring this chip, based on that shared base DT.
> 
> This is some early version, it's based on a merge of various -for-4.10
> branches from Maxime's repository.
> I can boot this on the OPi board and MMC and USB seem to work fine.
> I haven't tested any other peripherals yet.
> Some open issues:
> - The naming: Following the Allwinner scheme this should be "sun50i-h5"
> (which I use in this series), but it shares so much with the H3 that
> "sun8i-h5" wouldn't be wrong either. It gets a bit weird with that shared
> .dtsi, which I call sun8i-h3-h5.dtsi for now.
> - The clocks and pinctrl look _almost_ similar. I may sound like a broken
> record, but our habit of requiring kernel support for those almost identical
> SoCs really bites us now. As the MMC got updated, I fear there is _one_
> additional pin that we need for the HS400 transfer mode. Also I am afraid
> the MMC clock may be slightly different due to the advanced MMC support.
> At the moment this is not an issue, as the driver only support DDR50 at
> most anyway, so we get away with it now.
> I wonder if it's feasible to add those things to the existing H3 clocks
> and pinctrl to avoid another set of drivers.
> - I just see that I missed those patches that add just the names to the
> binding docs. I will send them once we agreed on the naming.

I don't have any major comments but I guess it all depends on the DT
maintainers view on the symbolic link to share the DTSI.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161124/938ef169/attachment-0001.sig>
