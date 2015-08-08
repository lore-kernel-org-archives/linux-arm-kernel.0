From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 08 Aug 2015 18:56:34 +0200
Subject: [BUG, RFC] Different bitfields in documentation and driver
In-Reply-To: <55C503A7.6020304@tul.cz> (Petr Cvek's message of "Fri, 07 Aug
 2015 21:14:47 +0200")
References: <55C503A7.6020304@tul.cz>
Message-ID: <87zj21k9bx.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Petr Cvek <petr.cvek@tul.cz> writes:

> Hello,
> It seems that PXA2xx framebuffer has switched bitfields in nonstd definition (when using overlay).
>
> This:
>
> 	http://lxr.free-electrons.com/source/drivers/video/fbdev/pxafb.h#L80
>
> versus this:
>
> 	http://lxr.free-electrons.com/source/Documentation/fb/pxafb.txt#L128
>
> Should be this changed in documentation or in driver? I was able to find only
> one use (in form of little outdated mplayer patch) and it fills both bitfields
> with zero (so potential change in driver will not break it).
I'd rather go for documentation. Not only the driver's way looks more pretty to
me, but it also guarantees compatibility from the kernel side.

> P.S. Lack of overlay2's use is probably caused by errata "E24: LCD: Enabling
> Overlay 2 for YUV420 hangs LCD controller.", which is not workarounded in this
> driver. It should be mentioned in documentation and/or code, because the only
> way to start the LCD again is a full PXA SoC reset.
Ok, do you know if this this true for all pxa variants and steppings or is this
for only a subset of them ?

Cheers.

-- 
Robert
