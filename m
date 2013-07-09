From: rogerq@ti.com (Roger Quadros)
Date: Tue, 9 Jul 2013 20:20:39 +0300
Subject: [PATCH] ARM: OMAP3: Beagle: Fix USB Host on beagle xM Ax/Bx
In-Reply-To: <51DC1B47.7070504@denx.de>
References: <1366024808-4691-1-git-send-email-rogerq@ti.com>
 <51DC09E7.1070302@denx.de> <51DC164B.5010608@ti.com>
 <51DC1B47.7070504@denx.de>
Message-ID: <51DC4667.3030305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2013 05:16 PM, Stefan Roese wrote:
> Hi Roger,
> 
> On 07/09/2013 03:55 PM, Roger Quadros wrote:
>>> I'm using latest kernel.org for this (git ID d2b4a646 also tested with
>>> v3.10 release). This is with DT-enabled booting and without-DT (same
>>> problem). I also tested some older Linux kernel versions and it fails
>>> there as well. Only v3.2.40 seems to be able to mount this rootfs via
>>> NFS reliably (approx. 10 times success).
>>
>> I can't really tell at the moment where the problem is.
>>
>> Did you compile in all the necessary drivers required for NFS booting?
>> In the beagle case that would mean NOP_USB_XCEIV, USB_EHCI_HCD, USB_EHCI_HCD_OMAP
>> and the smsc95xx driver.
> 
> Yes, sure. Otherwise no USB/NFS mount would have been possible.
> 
>> If you can paste your full kernel boot log we can check if all these show up
>> before the kernel tries to look up for the NFS server.
> 
> Please find it attached (one log for the NFS mount working and one for
> failing - both with exact the same kernel/dtb). Also my current .config.
> 

Thanks for the logs. Configuration part seems OK. NFS root has been mounted
in failing case as well. Then it fails. I'll need to investigate more what
happens. 

cheers,
-roger
