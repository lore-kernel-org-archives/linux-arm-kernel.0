From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 24 Sep 2011 09:06:00 +0100
Subject: [PATCH] arm: proc-v7: pc phy addresses before disable MMU
In-Reply-To: <1316851370-7284-1-git-send-email-per.forlin@stericsson.com>
References: <1316851370-7284-1-git-send-email-per.forlin@stericsson.com>
Message-ID: <20110924080600.GX17169@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 24, 2011 at 10:02:50AM +0200, Per Forlin wrote:
> PC runs virtual addresses when calling cpu_v7_reset(). The MMU
> is switched off and "mov pc, r0" sets pc back to
> virtual addresses even though the MMU is switched off.
> This will result in a crash if the pipeline delay after
> MMU disable is one instruction. To prevent this set PC
> to physical addresses before disabling the MMU.

This is broken - it assumes physical memory starts at zero.  That's
not the case for many platforms.
