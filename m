From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 19 Jul 2013 15:01:02 +0100
Subject: alignment handler instruction endian-ness
In-Reply-To: <20130719110947.GD24642@n2100.arm.linux.org.uk>
References: <51E91BE5.8070809@codethink.co.uk>
 <20130719110947.GD24642@n2100.arm.linux.org.uk>
Message-ID: <1374242462.3406.59.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-07-19 at 12:09 +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 19, 2013 at 11:58:45AM +0100, Ben Dooks wrote:
> > I ran in to an issue with the alignment handler when running BE8 where
> > it loads instructions and fails to swap.
> >
> > Is there a better way of swapping instructions for ARM when loading
> > from arbitrary places? Have I missed any other places this could happen?
> 
> Maybe we need a macro which deals with this automatically?

Like the stuff in arch/arm/include/asm/opcodes.h ?

> 	arm_instr_to_cpu(x)
> 	thumb_instr_to_cpu(x)
> 
> These should probably make use of the swab*() macros when an endian swap
> is needed.
> 
> > The following patch is my first attempt at solving the problem for the
> > alignment handler:
> 
> I'd suggest checking this with sparse too - you have some type errors here.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
