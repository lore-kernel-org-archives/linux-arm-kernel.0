From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Thu, 25 Dec 2014 09:32:40 +0100
Subject: v3.19-rc1 regression(?) on N900
In-Reply-To: <549B44E2.6080202@ti.com>
References: <549B44E2.6080202@ti.com>
Message-ID: <201412250932.40403@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 December 2014 23:57:38 Nishanth Menon wrote:
> based on automated testing with u-boot as a chained
> bootloader..
> 
> v3.18: boots fine:
> https://github.com/nmenon/kernel-test-logs/blob/v3.18/omap2plu
> s_defconfig/n900.txt
> 
> v3.19-rc1: hung
> https://github.com/nmenon/kernel-test-logs/blob/v3.19-rc1/omap
> 2plus_defconfig/n900.txt
> 
> in the interim, my farm had a bit of breakdown around the time
> of n900 breakdown..
> 
> as per my last functional linux-next logs:
> https://github.com/nmenon/kernel-test-logs/blob/next-20141204/
> omap2plus_defconfig/n900.txt -> hung.
> https://github.com/nmenon/kernel-test-logs/blob/next-20141112/
> omap2plus_defconfig/n900.txt -> working.
> 
> DEBUG_LL, CONFIG_DEBUG_OMAP3UART3=y and early_printk did not
> yield information either
> 
> Note: I am using the combined uImage+dtb image.[2]
> 
> I think this might just be my setup..(i use chained loader ->
> NOLO->u-boot->serial download->kernel) but anyways.. Since
> Pali thought others might be interested in sharing
> experience...
> 
> [1]   http://slexy.org/raw/s2osxhhwbR
> [2]
> https://github.com/nmenon/linux-2.6-playground/commit/177f5f71
> b3f21ea484ee4b09a2e0c015de522417

CCing other people.

I see same problem in qemu with 3.19-rc1 kernel when doing DT 
boot. In qemu I'm using direct booting from OneNAND (X-Loader --> 
NOLO --> kernel) without U-Boot. After NOLO load & boot kernel I 
do not see any other output from serial console. Also on qemu 
screen there is no new output (just NOKIA logo from bootloader).

I do not have this problem when doing legacy/board code boot with 
3.19-rc1 kernel, so this problem is related to DT.

Kernel 3.18-rc1 worked fine for both DT and legacy boot.

Can somebody look what broke DT booting?

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141225/8838583b/attachment.sig>
