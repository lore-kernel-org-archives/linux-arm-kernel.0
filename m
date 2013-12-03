From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Tue, 3 Dec 2013 15:49:05 +0000
Subject: [Xen-devel] [PATCH] xen/block: Correctly define structures in
 public headers on ARM32 and ARM64
In-Reply-To: <529DF897.1080303@linaro.org>
References: <1386083382-7306-1-git-send-email-julien.grall@linaro.org>
 <529E039A02000078001097F5@nat28.tlf.novell.com>
 <529DF897.1080303@linaro.org>
Message-ID: <1386085745.13256.51.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-12-03 at 15:28 +0000, Julien Grall wrote:
> On 12/03/2013 03:15 PM, Jan Beulich wrote:
> >>>> On 03.12.13 at 16:09, Julien Grall <julien.grall@linaro.org> wrote:
> >> --- a/include/xen/interface/io/blkif.h
> >> +++ b/include/xen/interface/io/blkif.h
> >> @@ -146,7 +146,7 @@ struct blkif_request_segment_aligned {
> >>  struct blkif_request_rw {
> >>  	uint8_t        nr_segments;  /* number of segments                   */
> >>  	blkif_vdev_t   handle;       /* only for read/write requests         */
> >> -#ifdef CONFIG_X86_64
> >> +#if defined(CONFIG_X86_64) || defined(CONFIG_ARM) || defined(CONFIG_ARM64)
> > 
> > Perhaps using
> > 
> > #ifndef CONFIG_X86_32
> > 
> > would be the better one, assuming that we won't add further
> > non-64-bit-clean ABI variants?
> 
> I'm fine with this solution. I will resend the patch.

Just a random thought but what about using the CONFIG_$ARCH to define a
more semantic name, like HAVE_4_BYTE_ALIGNED_QUAD_WORDS, or whichever
terminology for an 8-byte type is appropriate in the context.

Maybe Linux even already has such a #define?

Ian.
