From: broonie@kernel.org (Mark Brown)
Date: Mon, 1 Dec 2014 11:16:12 +0000
Subject: [PATCH v2 8/8] ARM: dts: mt8135: Add support for MT6397 regulator
In-Reply-To: <1417403967.9547.2.camel@mtksdaap41>
References: <1417146874-5232-1-git-send-email-flora.fu@mediatek.com>
 <1417146874-5232-9-git-send-email-flora.fu@mediatek.com>
 <20141128153008.GS7712@sirena.org.uk>
 <1417403967.9547.2.camel@mtksdaap41>
Message-ID: <20141201111612.GF7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 01, 2014 at 11:19:25AM +0800, Flora Fu wrote:
> On Fri, 2014-11-28 at 15:30 +0000, Mark Brown wrote: 

> > This appears to be the DT fragment for a SoC but you are defining the
> > system integration for the PMIC.  That's bad, the PMIC is a separate
> > device so should be hooked up by the board using it.  If there's common
> > elements from a reference design they should be in their own .dtsi.

> Do you mean that we should add a mt6397.dtsi and include it from
> mt8135.dtsi? For board specific, update them in mt8135.dtsi? 

More likely you should just add any integration needed in the board
file.  There should be no need to specify anything generically for the
regulators on a PMIC except registering the device.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141201/7e88de18/attachment.sig>
