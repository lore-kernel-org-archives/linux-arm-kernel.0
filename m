From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 27 Aug 2016 15:04:57 +0000
Subject: Older hisilicon chipsets
In-Reply-To: <7773f0e5-d045-1e93-529b-74a601467ed1@gmail.com>
References: <7773f0e5-d045-1e93-529b-74a601467ed1@gmail.com>
Message-ID: <20160827150457.GM10637@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marty,

+ Arnd, GregKH,

On Fri, Aug 26, 2016 at 07:48:06PM -0500, Marty Plummer wrote:
> It has recently come to my mind to begin working on an updated firmware
> for my employer's CCTV/DVR boxes, which are based around the Hi3520 line
> of arm SoC.

Ah, yes.  The same device we were discussing on #mvlinux?

> In the process of learning which files I need to edit in order to
> integrate my changes into the linux build system, I've come to find that
> arch/arm/mach-hisi/{Kconfig,Makefile} covers no less than four different
> chips from Hisilicon, and that seems to make it a bit awkward to insert
> a whole new arch/arm/mach- directory for one single SoC and create
> duplicate menuitems for Hisilicon.

Note that I have no experience with HiSilicon. :-)  However, I think
it's correct to add it mach-hisi/.   A quick grep shows that there is
devicetree support for hisilicon SoCs (arch/arm/boot/dts/).  So that
means there's a *lot* less code to add under mach-hisi/.

> So, I'm wondering whereabouts I should place the data for the chips that
> I am working on, for the sake of organization and whatnot.

Ideally, most of it will be a devicetree.  Assuming we have code for the
SoC and associated drivers.

> Also, I've been having difficulty getting a response from Hisilicon
> regarding my request for source code for this and a few other of their
> chips running in our other, newer DVRs, even though a cursory
> examination after accessing the devices via telnet shows they do in fact
> run a busybox/linux/uClibc based system, with a number of GPL licensed
> libraries and kernel modules.

I've added GregKH to the Cc to see if he knows of anyone currently
working with Hisilicon.

thx,

Jason.
