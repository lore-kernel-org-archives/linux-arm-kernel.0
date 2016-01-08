From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jan 2016 22:50:32 +0000
Subject: bcm4708-smartrg-sr400ac boot failures in next/arm-soc
In-Reply-To: <CANMBJr6LW=y7g4_CCutHf4vu5NkzoeXt_RvPSJAsTE2nFpGwqw@mail.gmail.com>
References: <CANMBJr6LW=y7g4_CCutHf4vu5NkzoeXt_RvPSJAsTE2nFpGwqw@mail.gmail.com>
Message-ID: <20160108225032.GO19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 02:33:39PM -0800, Tyler Baker wrote:
> After a bit of investigation, I determined that CONFIG_BLK_DEV_RAM was
> causing the issue and disabling it fixed the boot issue. Essentially,
> the kernel cannot find the initrd that has been loaded into memory by
> CFE bootloader with this option enabled as I inject the following
> command line into the DT before it's loaded over tftp.
> 
> Loaded in CFE by: 'load -raw -tftp -addr=0x4000000 -max=0x900000
> 192.168.2.2:tmpqC9zOv/ramdisk.cpio.gz'
> 
> Kernel arguments injected into DT: 'console=ttyS0,115200
> initrd=0x4000000,8M root=/dev/ram0 ip=dhcp'

What is the problem that the kernel is reporting?

I'm asking because kernelci.org uses javascript, which is not elinks
friendly, and it otherwise means I need to walk over to a different
machine to look at it, and then return to a different machine to finish
writing the email - as a result, I hardly ever look at the kernelci.org
results, and just rely on Olof's results.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
