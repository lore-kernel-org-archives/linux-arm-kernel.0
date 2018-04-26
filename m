From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 26 Apr 2018 02:24:22 -0700
Subject: [Linaro-mm-sig] noveau vs arm dma ops
In-Reply-To: <CAKMK7uG9R6paoP4BmvqDVUP_4Db4Dz8MSXeLwUBMYaORa5-kVw@mail.gmail.com>
References: <20180425054855.GA17038@infradead.org>
 <CAKMK7uEFitkNQrD6cLX5Txe11XhVO=LC4YKJXH=VNdq+CY=DjQ@mail.gmail.com>
 <CAKMK7uFx=KB1vup=WhPCyfUFairKQcRR4BEd7aXaX1Pj-vj3Cw@mail.gmail.com>
 <20180425064335.GB28100@infradead.org> <20180425074151.GA2271@ulmo>
 <20180425085439.GA29996@infradead.org>
 <20180425100429.GR25142@phenom.ffwll.local>
 <20180425153312.GD27076@infradead.org>
 <20180425225443.GQ16141@n2100.armlinux.org.uk>
 <CAKMK7uG9R6paoP4BmvqDVUP_4Db4Dz8MSXeLwUBMYaORa5-kVw@mail.gmail.com>
Message-ID: <20180426092422.GA26825@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 11:20:44AM +0200, Daniel Vetter wrote:
> The above is already what we're implementing in i915, at least
> conceptually (it all boils down to clflush instructions because those
> both invalidate and flush).

The clwb instruction that just writes back dirty cache lines might
be very interesting for the x86 non-coherent dma case.  A lot of
architectures use their equivalent to prepare to to device transfers.

> One architectural guarantee we're exploiting is that prefetched (and
> hence non-dirty) cachelines will never get written back, but dropped
> instead.

And to make this work you'll need exactly this guarantee.
