From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 May 2015 17:28:45 +0200
Subject: [PATCH] ARM: xz: do not try to use a ramdisk in defconfig
In-Reply-To: <CABymUCOAza58gFbaScsr8Bbw5WCFPTKj47Oq+qNYnVxN2u4JuA@mail.gmail.com>
References: <96091291.NVWbJdm5EK@wuerfel>
 <CABymUCOAza58gFbaScsr8Bbw5WCFPTKj47Oq+qNYnVxN2u4JuA@mail.gmail.com>
Message-ID: <3648496.HpmThcFSVv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 May 2015 08:49:25 Jun Nie wrote:
> 2015-05-18 23:24 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> > The original zx defconfig file looks for a ./rootfs.cpio file,
> > but that breaks with
> >
> >   scripts/gen_initramfs_list.sh: Cannot open 'initramfs.cpio.gz'
> >
> > when trying to build this kernel. Anybody who relies on the
> > current behavior should change their build scripts to append
> > the initramfs manually, as this patch removes that default
> > in order to help autmatic testing.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > I'm applying this directly to the next/defconfig branch to kernel the
> > kernelci builds.
> >
> Thanks for education. I learn it now 
> 

I've applied the patch now, and added "Acked-by: Jun Nie <jun.nie@linaro.org>".

Thanks,

	Arnd
