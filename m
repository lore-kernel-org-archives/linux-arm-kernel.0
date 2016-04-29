From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Apr 2016 19:12:48 +0100
Subject: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk
 numbering w/ device tree
In-Reply-To: <1461951139-6109-1-git-send-email-dianders@chromium.org>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
Message-ID: <20160429181248.GW19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2016 at 10:32:15AM -0700, Douglas Anderson wrote:
> This series picks patches from various different places to produce what
> I consider the best solution to getting consistent mmc and mmcblk
> ordering.
> 
> Why consistent ordering and why not just use UUIDs?  IMHO consistent
> ordering solves a few different problems:

NAK.  Really.  Use UUIDs, that's the proper solution here.

Exactly the same issue arises if you have more than one ATA or SCSI
adapter in your PC - things can be probed out of order and end up
in different /dev/sd* slots.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
