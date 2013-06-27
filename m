From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Jun 2013 16:22:26 +0200
Subject: [PATCH 1/4] Documentation: arm: [U]EFI runtime services
In-Reply-To: <CACxGe6tUpo31p6N0BZt_jdonuPP8ijvLBygC76wQ044EFsqOwA@mail.gmail.com>
References: <1372183863-11333-1-git-send-email-leif.lindholm@linaro.org>
 <1372183863-11333-2-git-send-email-leif.lindholm@linaro.org>
 <CACxGe6tUpo31p6N0BZt_jdonuPP8ijvLBygC76wQ044EFsqOwA@mail.gmail.com>
Message-ID: <201306271622.26494.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 June 2013, Grant Likely wrote:
> > index 0000000..5c48271
> > --- /dev/null
> > +++ b/Documentation/arm/uefi.txt
> > @@ -0,0 +1,39 @@
> > +The nomenclature EFI and UEFI are used interchangeably in this document.
> > +
> > +The implementation depends on receiving pointers to the UEFI memory map
> > +and System Table in a Flattened Device Tree - so is only available with
> > +CONFIG_OF.
> > +
> > +It (early) parses the FDT for the following parameters:
> 
> Need to state which node these properties can be found in. I recommend /chosen
> 
> I would also prefix all of the following properties with "linux,"
> since they are very much about what the Linux kernel needs for
> booting. EFI stub will be creating these properties specifically for
> Linux, and the LinuxLoader should do the same (until we eventually
> kill it).

Why not make it a separate /efi node instead, mirroring what we
have for hypervisor specific information and things like rtas?

	Arnd
