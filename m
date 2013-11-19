From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 20 Nov 2013 09:01:44 +1100
Subject: [PATCH 0/2] Revert support for reserved memory regions defined
 in device tree
In-Reply-To: <20131119151418.8BB2BC4079D@trevor.secretlab.ca>
References: <1381476448-14548-1-git-send-email-m.szyprowski@samsung.com>
 < 20131030134702.19B57C402A0@trevor.secretlab.ca>
 <528B5949.20204@samsung.com >
 <20131119151418.8BB2BC4079D@trevor.secretlab.ca>
Message-ID: <1384898504.26969.48.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-11-19 at 15:14 +0000, Grant Likely wrote:
> > The proposal look good for me. I'm not convinced that we really need the
> > support for 'reg' property, as the fixed memory region is a special case
> > of generic dynamic allocation specified by the size and alloc-ranges, but
> > I assume that there have been already a long discussion about this, so I
> > accept the common consensus.
> 
> It is absolutely necessary for some use cases. For example, a
> framebuffer enabled by firmware and passed onto the kernel for
> flicker-free boot. Some platforms have fixed regions that cannot be
> moved up.

Arguably that could be covered with alloc-range and size by making the range be
the reg property content basically (and thus size == size of range) but I
prefer the reg property, it's a clearer statement of intent.

Cheers,
Ben.
