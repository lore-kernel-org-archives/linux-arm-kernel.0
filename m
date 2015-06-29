From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Jun 2015 10:45:57 +0100
Subject: dma-mapping: support for DMA_ATTR_NON_CONSISTENT DMA attribute
In-Reply-To: <5590E962.4020700@topic.nl>
References: <CAF6-1L5c-PbK_wfpvz1xdRkquXyuQDv4mvKfYp8fwA1LK9ZOyw@mail.gmail.com>
 <20150628224543.GW7557@n2100.arm.linux.org.uk>
 <CAF6-1L4g0W6kboZt52fHBUPxGYWYn9-9vmm=0-WQVv1-YdfOEA@mail.gmail.com>
 <5590E962.4020700@topic.nl>
Message-ID: <20150629094557.GY7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 29, 2015 at 08:44:50AM +0200, Mike Looijmans wrote:
> ?On 29-06-15 07:24, Sylvain Munaut wrote:
> >""" By using this API, you are guaranteeing to the platform that you
> >have all the correct and necessary sync points for this memory in the
> >driver should it choose to return non-consistent memory."""
> >
> >I had assumed it was the dma_sync_* calls, but apparently not.
> 
> I think the answer is "the dma_sync_* calls plus whatever it is your DMA
> controller hardware needs to do"

No it is not.  When something is clearly the wrong API, you do not go
around telling people to use it.  I'm pretty disgusted that you think
that is an appropraite way to behave.

> If that's the case, where should I send the documentation patch?

It's not for me to say whether your patch is correct or not, it's for
the wider community to do so.  As there is no one "responsible" for
that documentation, I'd suggest sending it to Andrew Morton as nothing
else happened with it.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
