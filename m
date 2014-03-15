From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 15 Mar 2014 10:01:40 +0100
Subject: [PATCH v17 3/4] ata: Add APM X-Gene SoC AHCI SATA host controller
 driver
In-Reply-To: <CAPw-ZTkk3n_6wh-bWnaMf0aL6mgZWxNH7Sf=J9ucv0uvH2trVw@mail.gmail.com>
References: <1394655573-32645-1-git-send-email-lho@apm.com>
 <201403142206.36611.arnd@arndb.de>
 <CAPw-ZTkk3n_6wh-bWnaMf0aL6mgZWxNH7Sf=J9ucv0uvH2trVw@mail.gmail.com>
Message-ID: <201403151001.40400.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 March 2014, Loc Ho wrote:

> > I still think it's rather unlikely that we will actually see ACPI support
> > on your platform, btw.
> >
> > I'm willing to look at the patches you need for it, but I'm not very
> > optimistic, in particular because of the kind of hacks you need
> > for random bits of hardware.
> >
> 
> I am about to post another version. Can you look at the next version?
> If you still think it needs to be moved to the FW (either U-Boot or
> Tianocore UEFI boot loader), I will then move out of the Linux driver
> code.

I would certainly be happier if it could just be moved into the
firmware or boot loader all the time. The only times we actually
want to do this stuff in the kernel is when we can't trust the
boot loader to get it right, or when the kernel has to support
alternative configurations that the boot loader is not aware of,
e.g. when you can plug in different kinds of extension boards but
the boot loader doesn't know which one you have.

	Arnd
