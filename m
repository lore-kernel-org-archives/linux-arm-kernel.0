From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 2 Feb 2012 12:40:25 +0000
Subject: [RFC 5/7] OMAP: sdp4430: Add fixed regulator for twl6040 needs
In-Reply-To: <1328185019-29575-6-git-send-email-peter.ujfalusi@ti.com>
References: <1328185019-29575-1-git-send-email-peter.ujfalusi@ti.com>
 <1328185019-29575-6-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120202124025.GF7428@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 02:16:57PM +0200, Peter Ujfalusi wrote:
> The twl6040 VIO power is connected to SMPS V1V8, the
> V2V1 power is coming from SMPS V2V1 of twl6030.
> These are fixed, always on regulators.
> Create fixed voltage regulators for these supplies.

Shouldn't the PMIC be creating the relevant fixed voltage regulators?
It's a bit clearer given that the supplies actually come from the PMIC
and it would cut down a bit on the boilerplate in boards (though much
less so with device tree, sadly).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120202/bd01398d/attachment.sig>
