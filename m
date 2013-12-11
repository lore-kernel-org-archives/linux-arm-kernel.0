From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Dec 2013 22:51:16 +0000
Subject: [PATCH 2/2] regulator: s5m8767: Fix driver probe fail on BUCK7/8
 regulators
In-Reply-To: <1386666583-3280-2-git-send-email-k.kozlowski@samsung.com>
References: <1386666583-3280-1-git-send-email-k.kozlowski@samsung.com>
 <1386666583-3280-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20131211225116.GC11044@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 10:09:43AM +0100, Krzysztof Kozlowski wrote:
> The BUCK7 and BUCK8 were not supported by s5m8767 driver. If they were
> configured in DTS then the driver probing would fail with EINVAL:
> [    0.288474] VCC_SUB_1.35V: failed to apply 1350000uV constraint
> [    0.288671] s5m8767-pmic s5m8767-pmic: regulator init failed for 35
> [    0.294931] s5m8767-pmic: probe of s5m8767-pmic failed with error -22

> This patch adds support for BUCK7 and BUCK8 regulators using standard
> regmap get/set voltage sel functions.

I've applied these but this changelog doesn't entirely add up so I
rewrote it a bit.  The patch is implementing the get and set voltage
operations, the regulators were actually supported.  The errors were
being caused by the DT attempting to set the voltage for a fixed voltage
regulator which obviously won't work - I suspect that the DTs might not
be ideal, it seems common to overspecify voltages in DTs for some
reason.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131211/858fb28c/attachment.sig>
