From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Aug 2014 21:59:09 +0100
Subject: Building kernel for more than one SoC
In-Reply-To: <lsb9tn$nnv$1@ger.gmane.org>
References: <lrdi48$ls1$1@ger.gmane.org>
 <20140804201712.GK30282@n2100.arm.linux.org.uk> <53E8E469.9050807@atmel.com>
 <lsaoih$e9$1@ger.gmane.org>
 <CAOCHtYgPoxveSjYpWWo8W+_0WwQdaCBga0piazg_Oq6aeZ=w-g@mail.gmail.com>
 <lsb9tn$nnv$1@ger.gmane.org>
Message-ID: <20140811205909.GC30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 11, 2014 at 08:43:35PM +0000, Grant Edwards wrote:
> On 2014-08-11, Robert Nelson <robertcnelson@gmail.com> wrote:
> >> Now it's up to somebody else to decide if the price difference between
> >> a G20 and G25 is worth the engineering time to upgrade U-Boot and
> >> Linux kernel to versions that know about device trees...
> >
> > http://cateee.net/lkddb/web-lkddb/ARM_APPENDED_DTB.html
> 
> Interesting.  That would still require modifying U-Boot so that at
> run-time it detects the SoC type and appends the proper DTB to the
> kernel image, but it that may be less work than "real" DTB support in
> U-Boot.

The idea of that feature is:

- You take the kernel zImage
- You take the appropriate dtb file
- You concatenate the dtb file into the zImage
- You run mkimage on the resulting combined image to create the special
  uboot format file for uboot to load
- You use it with uboot as you have done in the past with non-DT kernels.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
