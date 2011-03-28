From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Mar 2011 18:58:58 +0100
Subject: [PATCH 1/1] ARM: dmabounce: fix dmabounce may cause crash issue
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F77214AB97@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1300965400-28304-1-git-send-email-b29396@freescale.com>
	<20110325083630.GA26481@n2100.arm.linux.org.uk>
	<65EE16ACC360FA4D99C96DC085B3F77214AB97@039-SN1MPN1-001.039d.mgd.msft.net>
Message-ID: <20110328175858.GA31457@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 28, 2011 at 05:01:31AM +0000, Dong Aisheng-B29396 wrote:
> But dma_map_single allows the 'dev' passed in to be NULL, so, may it be
> better to also check it for dmabounce in case such a using?

Programmers are lazy.  They often have a struct device laying around
but they think they'll not bother passing it into the DMA API and
end up just passing NULL as that seems to work for them.

That doesn't mean it'll always work.  The best thing is to always pass
in a struct device if there is one available.

I'm not saying don't for the dmabounce code.  I'm saying _also_ fix the
driver.
