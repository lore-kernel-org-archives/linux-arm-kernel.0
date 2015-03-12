From: stsp@list.ru (Stas Sergeev)
Date: Thu, 12 Mar 2015 16:16:03 +0300
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <20150312131207.GQ8656@n2100.arm.linux.org.uk>
References: <54FF21BE.2040506@list.ru>
 <20150311175227.499612af@free-electrons.com> <55007ADD.6080505@list.ru>
 <20150311174618.GE8656@n2100.arm.linux.org.uk> <55008483.8050603@list.ru>
 <20150311193343.0317e3e1@free-electrons.com> <55018A3C.7020409@list.ru>
 <20150312134756.5335cb32@free-electrons.com> <55018E8B.8060704@list.ru>
 <20150312131207.GQ8656@n2100.arm.linux.org.uk>
Message-ID: <55019193.6090406@list.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

12.03.2015 16:12, Russell King - ARM Linux ?????:
> On Thu, Mar 12, 2015 at 04:03:07PM +0300, Stas Sergeev wrote:
>> Yeah, I realize that, but I was hoping that some work-around
>> exists. For example, move entire dimm above 4G? Is this really
>> impossible? Or maybe move overlapping region above 8G...
> You /really/ don't want to do that.  We have that situation on TI Keystone
> SoCs and it's really horrible for the kernel to deal with.
>
> For early kernel boot, we require RAM below the 4GB boundary, so that
> we are able to execute code before the MMU is enabled.  No RAM below
> 4GB basically means there is no way to execute any code from RAM.
Then maybe it is possible to move the iomem to 1Gb and move
RAM above 1Gb, so that 3Gb of RAM are still available for early boot?
I mean, well, huh, giving up 256Mb of RAM so easily... :)
