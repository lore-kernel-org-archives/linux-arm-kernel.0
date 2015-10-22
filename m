From: ijc@debian.org (Ian Campbell)
Date: Thu, 22 Oct 2015 07:40:25 +0100
Subject: I/O issues with writing to mtdblock devices on kirkwood
In-Reply-To: <5628022A.9050707@mcfarlanes.me>
References: <1444722697.16876.55.camel@debian.org>
 <5626B4DC.8000407@mcfarlanes.me> <5627F4E8.3030907@mcfarlanes.me>
 <1445461864.32735.21.camel@debian.org> <5628022A.9050707@mcfarlanes.me>
Message-ID: <1445496025.32735.25.camel@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-10-21 at 22:22 +0100, Iain McFarlane wrote:

> >> 3.16 - No SATA errors when updating initrd - the kernel is flashed using
> >> dtb but how do I tell if it is used?
> [...]
> In which case it is using the board file
> 
> How do I force it to use the dtb?

If the DTB has been appended then it should Just Happen on reboot, I
think. I'm 99% certain that the 3.16 kernel in Jessie had the options
to enable DTB on this platform turned on. Specifically it should have
 CONFIG_ARCH_KIRKWOOD_DT=y.

You say "the kernel is flashed using the dtb", please could you post
the logs from flash-kernel to confirm this. And the dmesg from the
subsequent boot (whether board or DTB) would be useful too.

> On a different note anyone know why udev would not be running modprobe? 
> Every time I reboot this box I have to the reload any of the modules not
> specified in the initrd even things like mvmdio to get the network working.

I've no smart ideas, but you could maybe workaround by listing them in
/etc/modules?

Ian
