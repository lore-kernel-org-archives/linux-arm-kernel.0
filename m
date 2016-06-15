From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 15 Jun 2016 15:47:42 +0200
Subject: [PATCH 1/2] ARM: OMAP2+: Drop legacy board file for n900
In-Reply-To: <1465987689-14812-2-git-send-email-tony@atomide.com>
References: <1465987689-14812-1-git-send-email-tony@atomide.com>
 <1465987689-14812-2-git-send-email-tony@atomide.com>
Message-ID: <20160615134741.GA16860@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 15, 2016 at 03:48:08AM -0700, Tony Lindgren wrote:
> Let's drop the last two remaining omap3 legacy boot board files.
> Let's only use the device tree based booting known to work for
> these two boards.
> 
> We still have two omap3 boards booting in legacy mode in addition
> to device tree based booting. All the other ten or so omap2+ SoCs
> have been booting using device tree mode only for years now. This
> has allowed us to get rid of quite a bit of arch/arm/mach-omap2
> related platform init code in favor of dts and driver changes.
> 
> Pretty much the only remaining known users for omap3 legacy boot
> board files are Kevin's and Russell's boot test systems, and N900
> kernel tree maintained by Pali and Ivaylo. And all of them are
> also supporting the device tree based booting. The legacy booting
> mode has been kept around mostly to verify against regressions.
> 
> As there is still a slim chance of possible other uses of the
> mainline kernel for these boards, let's just drop the board
> files for v4.8, and let's not touch the related platform init
> code until around v4.9 time if no issues are found. This makes
> it trivial for us to add back the board files with a simple revert.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

I don't remember when I last booted N900 without DT, must have been
a couple of years :)

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160615/c3040af6/attachment.sig>
