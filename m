From: robert.richter@cavium.com (Robert Richter)
Date: Wed, 8 Feb 2017 15:43:28 +0100
Subject: [PATCH 1/9] irqchip/gic-v3-its: Fix command buffer allocation
In-Reply-To: <87tw847njl.fsf@on-the-bus.cambridge.arm.com>
References: <20170201173833.12630-1-rrichter@cavium.com>
 <20170201173833.12630-2-rrichter@cavium.com>
 <87tw847njl.fsf@on-the-bus.cambridge.arm.com>
Message-ID: <20170208144328.GS5020@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.02.17 14:41:18, Marc Zyngier wrote:
> On Wed, Feb 01 2017 at  5:38:25 pm GMT, Robert Richter <rrichter@cavium.com> wrote:
> > The its command buffer must be page aligned, but kzalloc() is not
> > guaranteed to be (though it is mostly when allocating 64k). Use
> > __get_free_pages() as this is used for other buffers as well.
> >
> > Signed-off-by: Robert Richter <rrichter@cavium.com>
> 
> I'm still going through this series, but as this is an obvious fix, I've
> cherry-picked it for 4.11.

That was actually my intention, thus I placed it first.

-Robert
