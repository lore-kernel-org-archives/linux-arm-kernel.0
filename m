From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 25 Nov 2011 10:12:32 +0000
Subject: [PATCH] ARM: Add optimised swahb32() byteswap helper for v6 and
 above
In-Reply-To: <alpine.LFD.2.02.1111231108330.17904@xanadu.home>
References: <1322059345-18842-1-git-send-email-dave.martin@linaro.org>
 <alpine.LFD.2.02.1111231108330.17904@xanadu.home>
Message-ID: <20111125101231.GB2098@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 11:09:00AM -0500, Nicolas Pitre wrote:
> On Wed, 23 Nov 2011, Dave Martin wrote:
> 
> > ARMv6 and later processors have the REV16 instruction, which swaps
> > the bytes within each halfword of a register value.
> > 
> > This is already used to implement swab16(), but since the native
> > operation performaed by REV16 is actually swahb32(), this patch
> > renames the existing swab16() helper accordingly and defines
> > __arch_swab16() in terms of it.  This allows calls to both swab16()
> > and swahb32() to be optimised.
> > 
> > The compiler's generated code might improve someday, but as of
> > 4.5.2 the code generated for pure C implementing these 16-bit
> > bytesswaps remains pessimal.
> > 
> > swahb32() is useful for converting 32-bit Thumb instructions
> > between integer and memory representation on BE8 platforms (among
> > other uses).
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> 
> Reviewed-by: Nicolas Pitre <nico@linaro.org>

Submitted to Russell's patch system as 7173/1.

Cheers
---Dave
