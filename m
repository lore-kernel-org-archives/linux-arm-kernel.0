From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 21 Aug 2012 17:38:05 +0100
Subject: [PATCH v3 1/4] arm/dts: regulator: Add tps65910 device tree data
In-Reply-To: <5033ADC5.4030002@wwwdotorg.org>
References: <1345547850-29761-1-git-send-email-anilkumar@ti.com>
 <1345547850-29761-2-git-send-email-anilkumar@ti.com>
 <5033ADC5.4030002@wwwdotorg.org>
Message-ID: <20120821163805.GW7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 09:48:21AM -0600, Stephen Warren wrote:

> This .dtsi file adds a node for every single regulator within the
> TPS65910, which in turn means that of_regulator_match() will find a node
> for every regulator, and in turn every regulator will be registered. On
> some boards, not all of those regulators will be used, and hence we
> don't want all of them to be registered.

This isn't the general view for the regualtor API - we generally want
all regulators to be registered in order to allow us to see what's going
on with things even if we've not figured them out from software.

> If dtc allowed /include/ inside a node rather than just at the
> top-level, that might solve this. Or, #defines to the board .dts could
> define the label name, and the .dtsi reference that label name.

I do constantly wish that more of the people churning out DT stuff would
look at the tooling around it :/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120821/9e93ce4f/attachment.sig>
