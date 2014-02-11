From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 11 Feb 2014 13:03:37 -0300
Subject: [PATCH 0/2] Marvell Armada 375 and 38x timer support
In-Reply-To: <1392059274-26965-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392059274-26965-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140211160335.GB24205@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel,

On Mon, Feb 10, 2014 at 04:07:52PM -0300, Ezequiel Garcia wrote:
> 
> This small series adds support for the two new Marvell ARM SoCs:
> the Armada 375 and Armada 38x.
> 

Please omit these patches entirely, we don't need them.

The new agreement [1] is to add SoC-specific compatible strings and also
declare the nodes as compatibles with the already supported SoC,
whenever appropriate.

[..]
> The A375 SoC timer is modeled matching the A370 timer, while the
> A38x SoC timer is modeled matching the AXP timer.
> 

So, as per the statement above, the devicetree for Armada 375 and
Armada 38x would have these timer nodes, respectively:

  timer {
      compatible = "marvell,armada-375-timer", "marvell,armada-370-timer"
  }

  timer {
      compatible = "marvell,armada-380-timer", "marvell,armada-xp-timer"
  }

(Because the Armada 375 timer uses the provided parent clock, whereas the
Armada 380 timer uses the fixed 25 MHz clock).

Therefore, we don't need any changes in the clocksource driver for now.

[1] http://www.spinics.net/lists/arm-kernel/msg306727.html
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
