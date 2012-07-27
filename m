From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Jul 2012 14:09:47 +0100
Subject: [DT] API to determine if interrupt is PPI or SPI ?
In-Reply-To: <50128AA0.8040409@gmail.com>
References: <53a41d02c4c4c24bdab47667183891bf.squirrel@www.codeaurora.org>
 <50128AA0.8040409@gmail.com>
Message-ID: <20120727130947.GN559@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2012 at 01:33:36PM +0100, Rob Herring wrote:
> On 07/26/2012 02:18 PM, rvaswani at codeaurora.org wrote:
> > Hello,
> > 
> > We can specify the interrupt information in the device tree using the arm
> > gic convention.
> > Is there an API to read directly the 1st cell and determine if an
> > interrupt is a PPI or a SPI ? This information is directly relevant to the
> > driver because it needs to call request_irq or request_percpu_irq based on
> > this data.
> > 
> > How should this be done ideally ?
> 
> Seems a bit strange to me that you would have a h/w block that can be
> connected either way...

The CPU PMU can be wired as either SPI or PPI. The latter makes more sense to
me but usually (although not exclusively) it's wired using the former.

Will
