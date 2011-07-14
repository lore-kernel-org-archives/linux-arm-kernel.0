From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 14 Jul 2011 20:30:45 +0200 (CEST)
Subject: CMOS camera interface on ARM
In-Reply-To: <loom.20110714T130539-468@post.gmane.org>
References: <loom.20110714T130539-468@post.gmane.org>
Message-ID: <Pine.LNX.4.64.1107142029380.10688@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Jul 2011, GIGIN JOSE wrote:

> Hi, 
> 
> I am working on ARM9 based linux embedded system. I need to 
> interface a CMOS camera on the SoC. The processor I use is 
> samsung s3c2416, which does not have a camera interface. 
> The linux version I use is 2.6.21

You need to use the latest kernel.

> 
> With the standard resolutions(640*480) and fps
>  (~25 fps) configured on the camera, I am getting the 
> clock rates as below:
> Master clock: 24 MHz
> Pixel Clock : 8MHz
> HSYNC       : 20KHz
> VSYNC       : 25Hz
> 
> The Bit Resolution I use is 8bpp. 
> 
> Using the regular interrupt lines (external interrupts),
>  will I be able to read the 8 bit camera data coming 
> with each pixel ? Can I do this with regular IRQ interrupt
>  or should I configure my interrupts to be FIQ ? 
> Is there any generic driver available for this 
> kind of interface in linux.

See drivers/media/video/s5p-fimc/ for an example, as well as other drivers 
under drivers/media/video/

Thanks
Guennadi

> What is the interrupt
>  latency if I configure the external interrupts in FIQ mode 
> and IRQ mode ? 
> 
> 
> Thank You
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
