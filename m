From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Jun 2015 22:51:41 +0100
Subject: [PATCH 3/9] arm: add call to CPU idle quirks handler
In-Reply-To: <1435094387-20146-4-git-send-email-pawelo@king.net.pl>
References: <1435094387-20146-1-git-send-email-pawelo@king.net.pl>
 <1435094387-20146-4-git-send-email-pawelo@king.net.pl>
Message-ID: <20150623215141.GG7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 23, 2015 at 11:19:41PM +0200, Paul Osmialowski wrote:
> Some SoCs need additional actions to be performed after arch idle,
> e.g. Kinetis requires invalidation of the I/D bus cache.
> 
> Such handler could be held in provided <mach/idle.h> header file.

NAK.  This is what the arm_pm_idle hook is there for.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
