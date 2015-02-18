From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 18 Feb 2015 11:32:38 -0800
Subject: [PATCH 2/4] of: DT quirks infrastructure
In-Reply-To: <20150218173115.GG29429@leverpostej>
References: <1424271576-1952-1-git-send-email-pantelis.antoniou@konsulko.com>
 <1424271576-1952-3-git-send-email-pantelis.antoniou@konsulko.com>
 <20150218154106.GC29429@leverpostej>
 <FE61DD1C-51DA-4869-8A62-C019C3D70577@konsulko.com>
 <20150218173115.GG29429@leverpostej>
Message-ID: <20150218193238.GA32179@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 18, 2015 at 05:31:16PM +0000, Mark Rutland wrote:
> > >> +While this may in theory work, in practice it is very cumbersome
> > >> +for the following reasons:
> > >> +
> > >> +1. The act of selecting a different boot device tree blob requires
> > >> +a reasonably advanced bootloader with some kind of configuration or
> > >> +scripting capabilities. Sadly this is not the case many times, the
> > >> +bootloader is extremely dumb and can only use a single dt blob.
> > > 
> > > You can have several bootloader builds, or even a single build with
> > > something like appended DTB to get an appropriate DTB if the same binary
> > > will otherwise work across all variants of a board.
> > > 
> > 
> > No, the same DTB will not work across all the variants of a board.
> 
> I wasn't on about the DTB. I was on about the loader binary, in the case
> the FW/bootloader could be common even if the DTB couldn't.
> 
> To some extent there must be a DTB that will work across all variants
> (albeit with limited utility) or the quirk approach wouldn't work...
> 

Not necessarily. I have another use case: A cpu card can be plugged into
multiple carrier card variants, each with different functionality.
At production time, it is not known which carrier card the CPU card
will be plugged in. It is not feasible for manufacturing to update
the dtb files after the cpu card has been plugged into the carrier,
since both are manufactured separately and plugged together at a
later step in the production process (and may be swapped around later).

External overlays do not work in this case because those have to be loaded
through the carrier card. A common dtb file as proposed here would be an
elegant solution for that problem.

Guenter
