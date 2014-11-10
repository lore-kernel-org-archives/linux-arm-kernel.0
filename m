From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 10 Nov 2014 12:41:58 +0000
Subject: [PATCH v7 3/8] arm64: introduce is_device_dma_coherent
In-Reply-To: <alpine.DEB.2.02.1411101200080.22875@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1411051757140.22875@kaball.uk.xensource.com>
 <20141106103337.GA19702@e104818-lin.cambridge.arm.com>
 <alpine.DEB.2.02.1411061155200.22875@kaball.uk.xensource.com>
 <20141107110524.GA21875@localhost>
 <alpine.DEB.2.02.1411071212250.22875@kaball.uk.xensource.com>
 <20141107160006.GE29148@e104818-lin.cambridge.arm.com>
 <alpine.DEB.2.02.1411071646170.22875@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1411071732550.22875@kaball.uk.xensource.com>
 <20141107181430.GH29148@e104818-lin.cambridge.arm.com>
 <alpine.DEB.2.02.1411071834540.22875@kaball.uk.xensource.com>
 <20141110101645.GA21366@e104818-lin.cambridge.arm.com>
 <alpine.DEB.2.02.1411101200080.22875@kaball.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1411101240290.22875@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Nov 2014, Stefano Stabellini wrote:
> > BTW, pfn_valid() is more expensive than simply comparing the mfn with
> > pfn for dom0. The calling code knows this already and it may be quicker
> > to simply pass a "bool foreign" argument.
> 
> Good point, I can compare mfn and pfn here.
> I cannot do the same in unmap_page and the various sync operations,
> because there is no pfn available, but maybe I could use
> set_page_private to set a flag. I'll think about it.

But of course there is no struct page either so I think pfn_valid will
have to stay in unmap and sync
