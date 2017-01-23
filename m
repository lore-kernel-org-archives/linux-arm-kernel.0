From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 23 Jan 2017 13:34:04 +0100
Subject: [PATCH 1/2] dt-bindings: gpu: Add Mali Utgard bindings
In-Reply-To: <CAL_JsqL5fYVvCRgui9NQVEM+=gkGUnf7-D9KHK9YTtJyfGy3Ew@mail.gmail.com>
References: <20170116132424.7038-1-maxime.ripard@free-electrons.com>
 <CALAqxLV=5ZCu8=rDUFHS9148DxzrqeTipsueA7F4i3t-mcWr=A@mail.gmail.com>
 <20170120091608.ijdhpeq2t5no75rc@lukather>
 <CAL_JsqL5fYVvCRgui9NQVEM+=gkGUnf7-D9KHK9YTtJyfGy3Ew@mail.gmail.com>
Message-ID: <20170123123404.hb3ktetkn773tno4@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Fri, Jan 20, 2017 at 08:15:21AM -0600, Rob Herring wrote:
> > The only thing that might be vendor specific would be the (optional)
> > declaration of the mali_gpu_device_data structure. As far as I know,
> > there's two things of importance there:
> >   - the list of the valid OPPs in order to do DVFS, but that could be
> >     made generic too using the operating-points binding
> >
> >   - And the valid area for the buffers for the fbdev blobs (fb_start,
> >     fb_size and shared_mem_size). I'm not entirely happy with this one
> >     so far (which is also why I've not pushed it). We'd need to come
> >     up with a way to get the base address and size of the CMA region
> >     backing the framebuffer allocation, but I haven't find any trivial
> >     way to do so, so for now I just hardcoded it. Worst case scenario,
> >     we can hardcode values based on the compatible.
> 
> memory-region property?

That might do it, however those buffers usually are allocated by the
display engine, and not the GPU device. Even if we declare a reserved
memory region and use memory-region in the GPU node, chances are that
buffers allocated for the display may not be in that region (for
example if it's using the default CMA pool).

Unless we create a memory region for the default CMA pool?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170123/baa0c2b3/attachment.sig>
