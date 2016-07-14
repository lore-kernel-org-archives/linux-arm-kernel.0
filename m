From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Jul 2016 10:29:11 +0200
Subject: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <1678419.ODVtyXKVYJ@hactar>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <5108278.va6WuahHro@wuerfel> <1678419.ODVtyXKVYJ@hactar>
Message-ID: <4321972.HZgDox36RC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 13, 2016 11:18:04 PM CEST Thiago Jung Bauermann wrote:
> Am Mittwoch, 13 Juli 2016, 21:59:18 schrieb Arnd Bergmann:
> > On Wednesday, July 13, 2016 3:45:41 PM CEST Thiago Jung Bauermann wrote:
> > > Am Mittwoch, 13 Juli 2016, 15:13:42 schrieb Arnd Bergmann:
> > > 
> > > For secure boot, Petitboot needs to use kexec_file_load, because of the
> > > following two features which the system call enables:
> > > 
> > > 1. only allow loading of signed kernels.
> > > 2. "measure" (i.e., record the hashes of) the kernel, initrd, kernel
> > > 
> > >    command line and other boot inputs for the Integrity Measurement
> > >    Architecture subsystem.
> > > 
> > > Those can't be done with kexec_load.
> > 
> > Can't petitboot do both of these in user space?
> 
> To be honest I'm not sure if it *can't* be done from userspace but if you do 
> it from the kernel you can guarantee that any kernel image that is loaded 
> gets verified and measured.
> 
> Whereas if you verify and measure the kernel in userspace then if there's a 
> vulnerability in the system which allows an attacker to upload their own 
> binary, then they can use kexec_load directly and bypass the verification 
> and measurement.
> 
> So it's a more resilient design.

Right, but the question remains whether this helps while you allow the
boot loader to modify the dtb. If an attacker gets in and cannot modify
the kernel or initid but can modify the DT, a successful attack would
be a bit harder than having a modified kernel, but you may still need
to treat the system as compromised.

	Arnd
