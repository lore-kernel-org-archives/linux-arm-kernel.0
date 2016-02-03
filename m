From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 2 Feb 2016 19:20:58 -0500 (EST)
Subject: [PATCH 1/3] ARM: move .vectors and .stubs sections back into
 the kernel VMA
In-Reply-To: <20160203000351.GX10826@n2100.arm.linux.org.uk>
References: <1454419174-21290-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454419174-21290-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160203000351.GX10826@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.20.1602021918050.32766@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 3 Feb 2016, Russell King - ARM Linux wrote:

> On Tue, Feb 02, 2016 at 02:19:32PM +0100, Ard Biesheuvel wrote:
> > The sections themselves are emitted 4 KB apart, as required:
> >   ...
> >   [16] .stubs       PROGBITS   c0c35000 a35000 0002c0 00  AX  0   0 32
> >   [17] .vectors     PROGBITS   c0c34000 a44000 000020 00  AX  0   0  2
> >   ...
> 
> ... which means we end up wasting most of a page for absolutely no
> purpose what so ever.  Sorry, I'm really not happy about this
> gratuitous wastage.

In practice this shouldn't make much of a difference given zImage is 
compressed and large zero filled areas compress very well.

But this is not nice for XIP though.


Nicolas
