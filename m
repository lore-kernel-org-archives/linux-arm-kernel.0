From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Sep 2009 14:25:02 +0100
Subject: arm_syscall cacheflush breakage on VIPT platforms
In-Reply-To: <20090928131926.GB19778@shareable.org>
References: <20090928092919.GA30271@localhost>
	<20090928124922.GA19778@shareable.org>
	<20090928131624.GK30271@localhost>
	<20090928131926.GB19778@shareable.org>
Message-ID: <20090928132502.GF10671@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2009 at 02:19:26PM +0100, Jamie Lokier wrote:
> Aieee.  Is sys_cacheflush architecturally the Right Way to do DMA to
> userspace, or is it just luck that it happens to work?
> 
> Does that include O_DIRECT regular file I/O as used by databases on
> these ARMs?  (Nobody ever gives a straight answer)

Most definitely not.  As far as O_DIRECT goes, I've no idea what to do
about that, or even if it's a problem.  I just don't use it so it's
not something I care about.

I wouldn't even know _how_ to use it or even how to provoke any bugs
in that area.
