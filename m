From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 May 2018 17:33:43 +0100
Subject: [PATCH v4 0/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <cover.1527040878.git.collinsd@codeaurora.org>
References: <cover.1527040878.git.collinsd@codeaurora.org>
Message-ID: <20180530163343.GV6920@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2018 at 07:43:16PM -0700, David Collins wrote:
> This patch series adds a driver and device tree binding documentation for
> PMIC regulator control via Resource Power Manager-hardened (RPMh) on some
> Qualcomm Technologies, Inc. SoCs such as SDM845.  RPMh is a hardware block

So, this is a very big driver and obviously it being RPM based it
doesn't look like other regulators which is causing problems, especially
when coupled with the desire to implement a bunch of more exotic
features like the mode setting.  I think this review is going to go a
lot more smoothly if you split this up into a base driver with just
normal, standard stuff that doesn't add too many custom properties or
unusual ways of working and then a series of patches on top of that
adding things like the mode adjustment and interaction with other RPM
clients.

We've got other RPM based regulators in tree already so the baseline bit
shouldn't be too hard, that'll make the rest of the patches much smaller
and easier to review and mean that the bits that are simpler and easier
to cope with don't need to be reposted.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180530/fd8d3adf/attachment.sig>
