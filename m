From: hongxing.zhu@nxp.com (Richard Zhu)
Date: Mon, 18 Jul 2016 07:38:36 +0000
Subject: PROBLEM: pcie imx6 link problem after a random number of reboot
In-Reply-To: <CAO1575VjjoA3O-8big2NG7v=xCeeLjf1K0Ck7b9AUcZ=H8HL1w@mail.gmail.com>
References: <CAO1575Vzw5=JMVW4yh6HNz730r-RtONt_+J1A4BhygVowAWLZQ@mail.gmail.com>
 <CAO1575Wo_Qgk-YX7kZchUTEv7o3W5-b_DJQktoF2AR+OwvAxNg@mail.gmail.com>
 <VI1PR0401MB2624BC92B13026C53D4B13198C330@VI1PR0401MB2624.eurprd04.prod.outlook.com>
 <CAO1575VC_cVHMxnWWDHcJhrymchJM1zMmR4X2O38JdrGP4dJfA@mail.gmail.com>
 <VI1PR0401MB26249BF2429EF9FD6DB7F7EF8C330@VI1PR0401MB2624.eurprd04.prod.outlook.com>
 <CAO1575VjjoA3O-8big2NG7v=xCeeLjf1K0Ck7b9AUcZ=H8HL1w@mail.gmail.com>
Message-ID: <VI1PR0401MB2624E3404F95241302CC4C9F8C360@VI1PR0401MB2624.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ivan:


> -----Original Message-----
> From: Ivan Grimaldi [mailto:grimaldi.ivan at gmail.com]
> Sent: Friday, July 15, 2016 9:55 PM
> To: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: r65037 at freescale.com; l.stach at pengutronix.de; linux-pci at vger.kernel.org;
> bhelgaas at google.com; linux-arm-kernel at lists.infradead.org
> Subject: Re: PROBLEM: pcie imx6 link problem after a random number of
> reboot
> 
> Hi ,
> 
>  i have aligned pci-imx.c file with SHA
> "b2d7a9cd3ff8ec561348267c2ef7d47b2b91e801" (same of kernel 4.6) and after
> a random number of restart the kernel hangs (below the kernel log). From log,
> as you see, the U-Boot haven't problem with PCI.
[Zhu hongxing] The link training of kernel pcie would be impacted by the the link up state of
 the uboot pcie. 
> 
> ...
> U-Boot 2015.01-ge2977fb-dirty (Jul 15 2016 - 11:28:42)
> 
> CPU:   Freescale i.MX6DL rev1.1 at 792 MHz
> Reset cause: WDOG
>        Watchdog enabled
> DRAM:  1 GiB
> Flash: 96 MiB
> MMC:   FSL_SDHC: 0
> WARNING: Make sure the PCIe #PERST line is connected!
>   00:01.0     - 16c3:abcd - Bridge device
>    01:00.0    - 14e4:b242 - Network controller
> In:    serial
> Out:   serial
> Err:   serial
> Net:   FEC [PRIME]
> Hit any key to stop autoboot:  0
> Booting from NFS...
> Using FEC device
> TFTP from server 192.168.74.130; our IP address is 192.168.74.235 Filename
> 'ags20.dtb'.
> Load address: 0x12000000
> Loading: ###
>          3.2 MiB/s
> done
> Bytes transferred = 29921 (74e1 hex)
> Using FEC device
> TFTP from server 192.168.74.130; our IP address is 192.168.74.235 Filename
> 'zImage'.
> Load address: 0x12100000
> Loading:
> ################################################################
> #
> 
> ################################################################
> #
> 
> ################################################################
> #
>          ##########################################
>          3.9 MiB/s
> done
> Bytes transferred = 3472120 (34faf8 hex) Kernel image @ 0x12100000
> [ 0x000000 - 0x34faf8 ] ## Flattened Device Tree blob at 12000000
>    Booting using the fdt blob at 0x12000000
>    Loading Device Tree to 4f530000, end 4f53a4e0 ... OK
> 
> Starting kernel ...
> 
[Zhu hongxing] It seems that the kernel is hang.
Most possible reason is that pcie register is accessed, but the clks is not configured properly.
Can you enable the " CONFIG_EARLY_PRINTK", and debug into it?

> 
> 
> Best regards
> IVan
> 
Snip...

Best Regards
hongxing zhu
Linux BSP team
Office: 86-21-28937189
Email: hongxing.zhu at nxp.com
