From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 23 Nov 2015 17:04:42 -0800
Subject: [RFC/PATCH 2/3] recordmcount: Record locations of
 __aeabi_{u}idiv() calls on ARM
In-Reply-To: <20151123213337.GX8644@n2100.arm.linux.org.uk>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <1448068997-26631-3-git-send-email-sboyd@codeaurora.org>
 <20151121101349.GI8644@n2100.arm.linux.org.uk>
 <20151123205335.GD19156@codeaurora.org>
 <20151123210347.GW8644@n2100.arm.linux.org.uk>
 <20151123211601.GE19156@codeaurora.org>
 <20151123213337.GX8644@n2100.arm.linux.org.uk>
Message-ID: <20151124010442.GP19156@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23, Russell King - ARM Linux wrote:
> On Mon, Nov 23, 2015 at 01:16:01PM -0800, Stephen Boyd wrote:
> > Thanks. I don't see the prints on my system even with this config
> > on top of allyesconfig. Odd.
> 
> Hmm.
> 
> It could be because I use ccache in hardlink mode to avoid the disk
> overhead of having two copies and having to duplicate the file
> contents.
> 
> If the kernel build thinks it can modify an object file in place, it
> will lead to this, as it will end up modifying the stored ccache
> file unless it specifically breaks the hardlink.
> 

That sounds very possible. I'd have to get ccache setup with
hardlinks to test out your theory. 

Is it supported to use ccache with hardlinks to build the kernel?
The ccache documentation makes it sounds like it will confuse
make and isn't a good idea.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
