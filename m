From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Jun 2017 23:05:50 +0100
Subject: [RFC PATCH v2 1/2] ARM: iwmmxt: Add missing __user annotations
 to sigframe accessors
In-Reply-To: <1498583067-14178-2-git-send-email-Dave.Martin@arm.com>
References: <1498583067-14178-1-git-send-email-Dave.Martin@arm.com>
 <1498583067-14178-2-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170627220550.GS4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 27, 2017 at 06:04:06PM +0100, Dave Martin wrote:
> preserve_iwmmxt_context() and restore_iwmmxt_context() lack __user
> accessors on their arguments pointing to the user signal frame.
> 
> There does not be appear to be a bug here, but this omission is
> inconsistent with the crunch and vfp sigframe access functions.
> 
> This patch adds the annotations, for consistency.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Absolutely the right thing to do.  Please drop this into the patch system,
thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
