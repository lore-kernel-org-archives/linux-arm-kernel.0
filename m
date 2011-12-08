From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 Dec 2011 16:22:19 -0800
Subject: [PATCH 1/5] arm/dt: tegra: Remove /memreserve/ from device-tree
 files
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF174F08C3BC@HQMAIL01.nvidia.com>
References: <1321911851-10091-1-git-send-email-swarren@nvidia.com>
 <2308525.meomQFtUnY@ax5200p>
 <74CDBE0F657A3D45AFBB94109FB122FF174F08C3BC@HQMAIL01.nvidia.com>
Message-ID: <20111208002219.GL12945@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 08:25:03AM -0800, Stephen Warren wrote:
> Marc Dietrich wrote at Tuesday, November 22, 2011 3:42 AM:
> > On Monday 21 November 2011 14:44:07 Stephen Warren wrote:
> > > There are no drivers in the kernel at present which can make use of the
> > > memory reserved by /memreserve/, so there is no point reserving it. Remove
> > > /memreserve/ to allow the user more memory. It's also unclear whether any
> > > future driver would actually require /memreserve/, or allocate memory
> > > through some other mechanism.
> > 
> > while this gives 512 MB of usable memory on my AC100, it causes some funny
> > pictures on the screen ;-) I guess our bootloader (fastboot) already setups
> > the frambuffer there (and enables the backlight). I guess it shouldn't be
> > harmful as nothing else writes to this memory area. Otherwise you may add that
> > the bootloader (or the kernel cmdline supplied by the bootloader) is now
> > responsible for the reservation to the description.
> 
> Ah yes, I guess that would happen. I'm only testing with mainline U-Boot...
> 
> I'd suggest this is acceptable fallout for now; I don't believe it will
> cause any active problems, and as you say, you can get the bootloader to
> set a command-line that excludes the frame-buffer if you want to solve
> this. Do you agree?

Agreed. It would make more sense to teach u-boot to reserve the memory.


-Olof
