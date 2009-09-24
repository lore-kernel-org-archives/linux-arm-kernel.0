From: wookey@wookware.org (Wookey)
Date: Thu, 24 Sep 2009 16:10:10 +0100
Subject: patches for pxafb
In-Reply-To: <3ea34a000909240715i2742faa8r83f574e7d652d3b9@mail.gmail.com>
References: <3ea34a000909240715i2742faa8r83f574e7d652d3b9@mail.gmail.com>
Message-ID: <20090924151010.GS12991@dream.aleph1.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+++ Christopher Friedt [2009-09-24 16:15 +0200]:
> Hi folks,
> 
> I have a couple of patches for the pxa framebuffer that I would like
> to submit upstream,
> but I'm fairly new to it and thought that this would be a good place to start.
> 
> [1] add width / height members to struct pxafb_mach_info, and related
> code in pxafb.c
> 
> * useful for providing physical display dimensions to the struct
> fb_var_screeninfo
> * some applications (namely Android) will look for these metrics to
> get an idea of
>   what the pixels-per-inch ratio is
> * this is something that can vary on a per-machine basis, which is why
> I put it in
>   pxafb_mach_info

When you say per-machine do you mean per type of machine, or per
device?

So far as I can see the pxa framebuffer stuff assumes that
every pxa mach type has exactly one display associated with it and
this is built in to the the kernel. This is very tiresome on balloon3,
which so far has had 4 different framebuffer-based displays (QVGA, VGA
LCDs and VGA/SVGA via interface to real monitor) and two
others (accessed over the samosa IO bus), which correspond to 'no frame
buffer'. We currently need different kernel configs and different
kernels to support these which seems deeply crufty, but I'm really not
sure how to go about having displays run or boot-time configurable. 
Has anyone thought about how this should be done?

Sorry if this is too far off topic for the simple change mooted, but
it seems to me to be part of the same discussion. 

Wookey
-- 
Principal hats:  iEndian - Balloonboard - Toby Churchill - Emdebian
http://wookware.org/
