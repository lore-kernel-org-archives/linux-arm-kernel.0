From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 14 Aug 2018 10:41:12 +0200
Subject: [RFC PATCH 0/7] add at91sam9 LCDC DRM driver
In-Reply-To: <264d51a0-7e41-6c27-d438-9ae337e6dcf0@microchip.com>
References: <20180812184152.GA22343@ravnborg.org>
 <20180812195536.GA29811@ravnborg.org>
 <264d51a0-7e41-6c27-d438-9ae337e6dcf0@microchip.com>
Message-ID: <20180814084112.GE21634@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 13, 2018 at 04:47:26PM +0200, Nicolas Ferre wrote:
> On 12/08/2018 at 21:55, Sam Ravnborg wrote:
> > The at91sam9263 has a few interesting "GPU" features:
> > 
> > - 2D memory addressing
> >    Data sheet says:
> > 	The LCDC can be configured to work on a frame buffer
> > 	larger than the actual screen size. By changing the
> > 	values in a few registers, it is easy to move the
> > 	displayed area along the frame buffer width and height
> > 
> > - 2D Graphics controller
> >    Data sheet says:
> > 	The Two D Graphics Controller (TDGC) features a
> > 	hardware accelerator which highly simplifies drawing
> > 	tasks and graphic management operations.
> > 	The hardware accelerator makes it easy to draw lines
> > 	and complex polygons and to perform block transfers
> > 	within the frame buffer.
> > 	The TDGC also features a draw command queue that
> > 	automatically executes a more complex drawing function
> > 	that is composed of several register accesses.
> > 
> > The datasheet text is from: chapter 43.9 + chapter 44:
> > http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-6249-32-bit-ARM926EJ-S-Embedded-Microprocessor-SAM9263_Datasheet.pdf
> > (No NDA required)
> 
> (old memories) this 2D engine prove itself of being quite limited as the
> fill polygon and clipping functions are not working.
> 
> > Based on the above, would it be possible to utilise some
> > of these features without any dedicated userspace (mesa) support?
> > Any other driver that has something similar that can be used
> > for inspiration?
> 
> This is really an interesting question indeed.

Needs userspace like everything else. There's unfortunately no real
standard for 2d apis in userspace, which means none of these efforts go
very far. Mostly it's just some custom-made X drivers.

Adding a generic 2d api to drm is a FAQ, and the answer is "no".
-Daniel

> 
> > Or is this in reality a simple GPU that requires a
> > dedicated GPU driver?
> > 
> > 	Sam
> > 
> 
> 
> -- 
> Nicolas Ferre
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
