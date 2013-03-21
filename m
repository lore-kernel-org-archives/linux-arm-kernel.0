From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Mar 2013 19:20:46 +0000
Subject: [PATCH 08/16] thermal: mvebu: Fix temperature output formula
 for kirkwood
In-Reply-To: <1363818997-23137-9-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1363818997-23137-9-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130321192046.GQ4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 07:36:29PM -0300, Ezequiel Garcia wrote:
> The temperature formula was taken from the Armada 510 datasheet.
> This is wrong because the Kirkwood SoC thermal sensor has
> different coefficients.
> 
> Fix it using values from 88F682/88F683 Kirkwood datasheet.

Err, hang on.  You've changed this from being a Kirkwood specific
driver to being a "mvebu" driver, which I had understood was being
done to cover all Kirkwood, Dove, etc SoCs.

If that's the case, then this change is wrong because you break it
for Dove.

If the coefficients are different between Kirkwood and Dove, then
it needs to be adapted at run time depending on whether it's running
on Kirkwood or Dove - not just having the coefficients changed at
compile time to suit a different set of platforms.

If it's worth making a change, do it *properly*.
