From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Apr 2014 21:03:24 +0200
Subject: Big endian working?
In-Reply-To: <5343BDEE.4010005@linaro.org>
References: <20140408095446.0520dd28@skate> <5343BDEE.4010005@linaro.org>
Message-ID: <12950765.TpxjkTx5NP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 April 2014 12:14:22 Taras Kondratiuk wrote:
> On 04/08/2014 10:54 AM, Thomas Petazzoni wrote:
> > Hello Taras,
> >
> > I'm currently trying to get ARM BE to work on Armada XP. I'm pretty
> > sure it used to work on 3.13, but now I'm testing 3.13 and 3.14 and it
> > doesn't boot here (it hangs even before "Uncompressing kernel...",
> > apparently while relocating the kernel image before decompression).
> >
> > Ben Dooks told me that the ARM BE kernel works for you. Can you confirm
> > which kernel version you're using, and if you've applied any patch?
> > Also, can you confirm which toolchain and toolchain version you're
> > using?
> 
> Hi Tom
> 
> To boot BE kernel from LE u-boot I'm using a few patches on top of 
> upstream kernel.
> 
> git://git.linaro.org/people/taras.kondratiuk/linux.git arm-be-boot-le
> 
> ----------------------------------------------------------------
> Ben Dooks (1):
>        ARM: add CPU_BE8_BOOT_LE configuration
> 
> Nico Pitre (1):
>        ARM: ensure loader information in LE format for BE kernels

Sorry for lacking the history on this patch set, but why would
you ever want to have this as a compile-time conditional?

Did anyone really put a u-boot on shipping hardware that expects
the headers in big-endian format?

	Arnd
