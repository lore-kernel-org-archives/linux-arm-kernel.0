From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 28 Nov 2013 18:35:54 -0800
Subject: [RFC PATCH] Documentation: devicetree: add description for
 generic bus properties
In-Reply-To: <20131128233147.GA19387@obsidianresearch.com>
References: <20131127172806.GC2291@e103592.cambridge.arm.com>
 <20131128203322.GB14689@mithrandir>
 <20131128211009.GA26447@obsidianresearch.com>
 <20131128222232.GF14689@mithrandir>
 <20131128233147.GA19387@obsidianresearch.com>
Message-ID: <20131129023554.GA14239@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 28, 2013 at 04:31:47PM -0700, Jason Gunthorpe wrote:
> > Perhaps this is just another way of saying what Greg has already said.
> > If we continue down this road, we'll eventually end up having to
> > describe all sorts of nitty gritty details. And we'll need even more
> 
> Greg's point makes sense, but the HW guys are not designing things
> this way for kicks - there are real physics based reasons for some of
> these choices...
> 
> eg An all-to-all bus cross bar (eg like Intel's ring bus) is engery
> expensive compared to a purpose built muxed bus tree. Doing coherency
> look ups on DMA traffic costs energy, etc.

Really?  How much power exactly does it take / save?  Yes, hardware
people think "software is free", but when you can't actually control the
hardware in the software properly, well, you end up with something like
itanium...

> > code to deal with those descriptions and the hardware they represent. At
> > some point we need to start pushing some of the complexity back into
> > hardware so that we can keep a sane code-base.
> 
> Some of this is a consequence of the push to have the firmware
> minimal. As soon as you say the kernel has to configure the address
> map you've created a big complexity for it..

Why the push to make firmware "minimal"?  What is that "saving"?  You
just push the complexity from one place to the other, just because ARM
doesn't seem to have good firmware engineers, doesn't mean they should
punish their kernel developers :)

greg k-h
