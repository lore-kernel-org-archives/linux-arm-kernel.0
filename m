From: jajones@nvidia.com (James Jones)
Date: Wed, 24 Nov 2010 11:08:47 -0800
Subject: [PATCH] ARM: Fix find_next_zero_bit and related assembly
In-Reply-To: <alpine.LFD.2.00.1011241357520.9313@xanadu.home>
References: <1289524615-22484-1-git-send-email-jajones@nvidia.com>
	<4CED55A6.5090608@codeaurora.org>
	<alpine.LFD.2.00.1011241357520.9313@xanadu.home>
Message-ID: <201011241108.47776.jajones@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 November 2010 11:00:12 am Nicolas Pitre wrote:
> On Wed, 24 Nov 2010, Stephen Boyd wrote:
> > On 11/23/2010 03:28 PM, James Jones wrote:
> > > On Tuesday 23 November 2010 13:26:47 Nicolas Pitre wrote:
> > >> On Thu, 11 Nov 2010, James Jones wrote:
> > >>> The find_next_bit, find_first_bit, find_next_zero_bit
> > >>> and find_first_zero_bit functions were not properly
> > >>> clamping to the maxbit argument at the bit level. They
> > >>> were instead only checking maxbit at the byte level.
> > >>> To fix this, add a compare and a conditional move
> > >>> instruction to the end of the common bit-within-the-
> > >>> byte code used by all the functions and be sure not to
> > >>> clobber the maxbit argument before it is used.
> > >>> 
> > >>> Signed-off-by: James Jones <jajones@nvidia.com>
> > >>> Tested-by: Stephen Warren <swarren@nvidia.com>
> > >> 
> > >> Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > >> 
> > >> Please send to RMK's patch system.
> > > 
> > > Thanks for the review.  It's already in the patch system, but I updated
> > > the entry to include your reviewed-by line.
> > 
> > Should this be sent to the stable tree too?
> 
> It could, yes.  This is hardly an urgent fix though, as the bug has been
> there virtually forever.
> 
> 
> Nicolas

While ancient, it does cause per-cpu allocations to fail in some situations, 
which generally causes panics.

Thanks,
-James
