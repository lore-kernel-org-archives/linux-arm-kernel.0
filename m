From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Nov 2015 21:33:37 +0000
Subject: [RFC/PATCH 2/3] recordmcount: Record locations of
 __aeabi_{u}idiv() calls on ARM
In-Reply-To: <20151123211601.GE19156@codeaurora.org>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <1448068997-26631-3-git-send-email-sboyd@codeaurora.org>
 <20151121101349.GI8644@n2100.arm.linux.org.uk>
 <20151123205335.GD19156@codeaurora.org>
 <20151123210347.GW8644@n2100.arm.linux.org.uk>
 <20151123211601.GE19156@codeaurora.org>
Message-ID: <20151123213337.GX8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 01:16:01PM -0800, Stephen Boyd wrote:
> Thanks. I don't see the prints on my system even with this config
> on top of allyesconfig. Odd.

Hmm.

It could be because I use ccache in hardlink mode to avoid the disk
overhead of having two copies and having to duplicate the file
contents.

If the kernel build thinks it can modify an object file in place, it
will lead to this, as it will end up modifying the stored ccache
file unless it specifically breaks the hardlink.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
