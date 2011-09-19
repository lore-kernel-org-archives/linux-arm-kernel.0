From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Sep 2011 15:41:37 +0100
Subject: [PATCH] ARM: kdump: copy kernel relocation code at the kexec
	prepare stage
In-Reply-To: <53612FE6B944314AAADB181E45A45B641387938501@sc-vexch3.marvell.com>
References: <1316151129-30491-1-git-send-email-leiwen@marvell.com>
	<20110919122059.GQ16381@n2100.arm.linux.org.uk>
	<53612FE6B944314AAADB181E45A45B641387938501@sc-vexch3.marvell.com>
Message-ID: <20110919144136.GT16381@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2011 at 07:11:59AM -0700, Lei Wen wrote:
> Thanks for this reminding!
> Then how about add flush_icache_range at the end of machine_kexec_prepare?
> Could it be acceptable?

I think it should be done.

> Also with this change, do we still need flush icache at the end stage of
> machine_kexec?

You need to use flush_icache_range() whenever you write _instructions_
to an area of memory which you intend to execute.  If you're not writing
instructions, you shouldn't use flush_icache_range().
