From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Feb 2015 14:37:15 +0000
Subject: [RFCv3 2/2] dma-buf: add helpers for sharing attacher
 constraints with dma-parms
In-Reply-To: <CAF6AEGu0-TgyE4BjiaSWXQCSk31VU7dogq=6xDRUhi79rGgbxg@mail.gmail.com>
References: <20150129143908.GA26493@n2100.arm.linux.org.uk>
 <CAO_48GEOQ1pBwirgEWeVVXW-iOmaC=Xerr2VyYYz9t1QDXgVsw@mail.gmail.com>
 <20150129154718.GB26493@n2100.arm.linux.org.uk>
 <CAF6AEGtTmFg66TK_AFkQ-xp7Nd9Evk3nqe6xCBp7K=77OmXTxA@mail.gmail.com>
 <20150129192610.GE26493@n2100.arm.linux.org.uk>
 <CAF6AEGujk8UC4X6T=yhTrz1s+SyZUQ=m05h_WcxLDGZU6bydbw@mail.gmail.com>
 <20150202165405.GX14009@phenom.ffwll.local>
 <CAF6AEGuESM+e3HSRGM6zLqrp8kqRLGUYvA3KKECdm7m-nt0M=Q@mail.gmail.com>
 <20150203074856.GF14009@phenom.ffwll.local>
 <CAF6AEGu0-TgyE4BjiaSWXQCSk31VU7dogq=6xDRUhi79rGgbxg@mail.gmail.com>
Message-ID: <20150203143715.GQ8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 03, 2015 at 09:04:03AM -0500, Rob Clark wrote:
> Since I'm stuck w/ an iommu, instead of built in mmu, my plan was to
> drop use of dma-mapping entirely (incl the current call to dma_map_sg,
> which I just need until we can use drm_cflush on arm), and
> attach/detach iommu domains directly to implement context switches.
> At that point, dma_addr_t really has no sensible meaning for me.

So how do you intend to import from a subsystem which only gives you
the dma_addr_t?

If you aren't passing system memory, you have no struct page.  You can't
fake up a struct page.  What this means is that struct scatterlist can't
represent it any other way.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
