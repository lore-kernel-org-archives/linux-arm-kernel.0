From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 6 Dec 2013 16:20:22 +0100
Subject: [PATCH 2/4] ARM: tegra: enable I2C controllers on Venice2
In-Reply-To: <1386196016-25128-2-git-send-email-swarren@wwwdotorg.org>
References: <1386196016-25128-1-git-send-email-swarren@wwwdotorg.org>
 <1386196016-25128-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131206152021.GE32372@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 04, 2013 at 03:26:54PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Enable all the I2C controllers that are wired up on Venice2. I don't
> know the correct I2C bus clock rates, so set them all to a conservative
> 100KHz for now.

Perhaps we should only enable those that we really need? I currently
use these in my local tree:

	i2c at 7000c400: for the trackpad
	i2c at 7000c700: for HDMI DDC
	i2c at 7000d000: for the PMIC

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131206/8cc4792e/attachment.sig>
