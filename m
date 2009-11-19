From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Nov 2009 10:49:12 +0000
Subject: drivers/rtc/rtc-pl031.c uses __raw_readl()?
In-Reply-To: <20091119094359.GF13376@n2100.arm.linux.org.uk>
References: <63386a3d0911110130j2056a355l16cade8d30edb6cd@mail.gmail.com>
	<63386a3d0911120043y2143c7f5w7289bc83b2e31847@mail.gmail.com>
	<20091113232637.GB8637@n2100.arm.linux.org.uk>
	<20091119094359.GF13376@n2100.arm.linux.org.uk>
Message-ID: <20091119104912.GI13376@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2009 at 09:43:59AM +0000, Russell King - ARM Linux wrote:
> So where do we stand on this?  Are Primecell registers always LE?  Or
> can they be BE if running in one of the BE modes?
> 
> I'm not merging the patch until we have a definitive answer on this.

Linus, you just said in the patch system that this is in akpm's tree.

Since we don't know whether this patch is even right or not, it's not
something which should be there.  It's not a bug fix nor is it a known
improvement.  It's just a hunch.

It may be that the existing code is correct and the other primecell
drivers that are using readb() rather than __raw_readb() need fixing.
We just don't know at present.
