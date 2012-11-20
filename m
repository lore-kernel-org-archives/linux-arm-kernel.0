From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Nov 2012 14:59:17 +0000
Subject: [PATCH] ARM: decompressor: Enable unaligned memory access for
 v6 and above
In-Reply-To: <20121120144934.GA1969@linaro.org>
References: <1352205711-15787-1-git-send-email-dave.martin@linaro.org>
 <20121120144934.GA1969@linaro.org>
Message-ID: <20121120145917.GT3290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 02:49:34PM +0000, Dave Martin wrote:
> On Tue, Nov 06, 2012 at 12:41:51PM +0000, Dave Martin wrote:
> > Modern GCC can generate code which makes use of the CPU's native
> > unaligned memory access capabilities.  This is useful for the C
> > decompressor implementations used for unpacking compressed kernels.
> > 
> > This patch disables alignment faults and enables the v6 unaligned
> > access model on CPUs which support these features (i.e., v6 and
> > later), allowing full unaligned access support for C code in the
> > decompressor.
> > 
> > The decompressor C code must not be built to assume that unaligned
> > access works if support for v5 or older platforms is included in
> > the kernel.
> > 
> > For correct code generation, C decompressor code must always use
> > the get_unaligned and put_unaligned accessors when dealing with
> > unaligned pointers, regardless of this patch.
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> > Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> Does anyone have any further comments on this before I send it to the
> patch system?

I don't, I think it's the right solution.  We keep ARMv6+ all working
the same, and this seems to be what GCC expects.
