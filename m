From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 20 Dec 2013 09:45:18 +0200
Subject: OMAP display subsystem - does it work?
In-Reply-To: <20131219165607.GN27438@atomide.com>
References: <20131218120023.GG4360@n2100.arm.linux.org.uk>
 <52B1A922.6020901@ti.com> <20131218180240.GG27438@atomide.com>
 <52B282BE.9050705@ti.com> <20131219165607.GN27438@atomide.com>
Message-ID: <52B3F58E.8060806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-12-19 18:56, Tony Lindgren wrote:

>>> Russell, maybe all you're missing is just omapfb.vram=0:2M,1:5M or similar
>>> from your kernel cmdline?
>>
>> Nothing like that should be required for normal operation.
> 
> Hmm maybe these instructions need some updating then:
> 
> http://omappedia.org/wiki/Bootargs_for_enabling_display

The page says omapfb.vram "can" be used, and "If the size is not
specified, frame buffers with default size are created". You only need
omapfb.vram option if you want to allocate extra memory for the fb.

The plain 'vram' option has no function anymore, now that we're using
normal dma alloc. So that part should be updated.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131220/19bb3721/attachment.sig>
