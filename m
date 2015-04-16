From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 16 Apr 2015 06:52:56 +0200
Subject: [PATCH] ARM: mvebu: armada-xp-openblocks-ax3-4: Disable
 internal RTC
In-Reply-To: <1429094447-4324-1-git-send-email-gregory.clement@free-electrons.com>
References: <1429094447-4324-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150416065256.53eca7b4@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Wed, 15 Apr 2015 12:40:47 +0200, Gregory CLEMENT wrote:
> There is no crystal connected to the internal RTC on the Open Block
> AX3. So let's disable it in order to prevent the kernel probing the
> driver uselessly. Eventually this patches removes the following
> warning message from the boot log:
> "rtc-mv d0010300.rtc: internal RTC not ticking"
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: <stable@vger.kernel.org> # v3.8 +

If an external crystal is needed on the board for the internal RTC,
then shouldn't instead the RTC have status = "disabled" in the
SoC-level .dtsi, and each board enabling it in its own
specific .dts, like we do for all other hardware blocks that
require/use external components/connexions?

Or, because the AX3 appears to be the only board in this case, we
decide to factorize enabling the RTC in the .dtsi, and leave it as a
special case to handle in the AX3 .dts ?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
