From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 31 Mar 2012 11:25:08 +0100
Subject: [PATCH 2/2] regulator: rename function regulator_register_fixed
In-Reply-To: <1333182812-423-2-git-send-email-shawn.guo@linaro.org>
References: <1333182812-423-1-git-send-email-shawn.guo@linaro.org>
 <1333182812-423-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120331102507.GB3163@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 31, 2012 at 04:33:32PM +0800, Shawn Guo wrote:

> Function regulator_register_fixed() is only meant for registering
> fixed dummy regulators.  Rename it to regulator_register_fixed_dummy()
> for the explicit meaning, so that people do not attempt to register
> those real fixed regulators with this function.

There's no harm in using it for regulators that physically exist if
nothing cares about any of the information it can't provide and renaming
it now is going to cause annoyance with cross tree issues so I'm kind of
reluctant to apply this.  Are there any concrete problems that have been
caused by this or was it just something you noticed when looking at
using it yourself?

> It also removes the kernel doc for @name which is not a parameter for
> the function at all.

This is already done, I can't remember who sent the patch off the top of
my head.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120331/7aa5e044/attachment-0001.sig>
