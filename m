From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 Nov 2011 00:24:37 +0000
Subject: [PATCH v8 15/16] ARM: LPAE: add support for ATAG_MEM64
In-Reply-To: <alpine.LFD.2.02.1111081832290.3307@xanadu.home>
References: <1320682618-1182-1-git-send-email-catalin.marinas@arm.com>
 <1320682618-1182-16-git-send-email-catalin.marinas@arm.com>
 <alpine.LFD.2.02.1111081832290.3307@xanadu.home>
Message-ID: <20111109002437.GA5256@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Tue, Nov 08, 2011 at 11:38:12PM +0000, Nicolas Pitre wrote:
> On Mon, 7 Nov 2011, Catalin Marinas wrote:
> 
> > From: Will Deacon <will.deacon@arm.com>
> > 
> > LPAE provides support for memory banks with physical addresses of up
> > to 40 bits.
> > 
> > This patch adds a new atag, ATAG_MEM64, so that the Kernel can be
> > informed about memory that exists above the 4GB boundary.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> NAK.  Any LPAE capable platform to come is, by definition, a new 
> platform.  It therefore should be using DT upfront.

Ok, well in that case it's a simple matter of defining #address-cells
correctly in your .dts and we can simply drop this patch. Does that sound
like the right approach?

Will
