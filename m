From: rogerq@ti.com (Roger Quadros)
Date: Tue, 9 Jul 2013 16:55:23 +0300
Subject: [PATCH] ARM: OMAP3: Beagle: Fix USB Host on beagle xM Ax/Bx
In-Reply-To: <51DC09E7.1070302@denx.de>
References: <1366024808-4691-1-git-send-email-rogerq@ti.com>
 <51DC09E7.1070302@denx.de>
Message-ID: <51DC164B.5010608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On 07/09/2013 04:02 PM, Stefan Roese wrote:
> Roger,
> 
> On 04/15/2013 01:20 PM, Roger Quadros wrote:
>> On Beagle xM Rev. Ax/Bx, the USB power enable GPIO logic is
>> reversed when compared to other revisions i.e. it is
>> active high instead of active low.
>>
>> Use the beagle_config.usb_pwr_level flag correctly so that
>> the power regulator can be configured at runtime.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> I'm currently trying to use an SMSC95xx USB ethernet adapter on the
> OMAP3 Beagleboard (old one "Beagle Rev C1/C2/C3") via the OMAP EHCI
> controller. And am testing this by trying to mount the rootfs via NFS.
> What I see is that the NFS mounting stalls/hangs most of the time quite
> early in the mount process:
> 
> [    6.425689] VFS: Mounted root (nfs filesystem) on device 0:12.
> [    6.435485] devtmpfs: mounted
> [    6.440002] Freeing unused kernel memory: 384K (c077a000 - c07da000)
> INIT: version 2.88 booting
> Starting udev
> [  188.311309] nfs: server 10.0.0.152 not responding, still trying
> [  188.317687] nfs: server 10.0.0.152 not responding, still trying
> ...
> 
> Only very seldom the rootfs can be mounted successfully to the prompt.
> 
> I'm using latest kernel.org for this (git ID d2b4a646 also tested with
> v3.10 release). This is with DT-enabled booting and without-DT (same
> problem). I also tested some older Linux kernel versions and it fails
> there as well. Only v3.2.40 seems to be able to mount this rootfs via
> NFS reliably (approx. 10 times success).

I can't really tell at the moment where the problem is.

Did you compile in all the necessary drivers required for NFS booting?
In the beagle case that would mean NOP_USB_XCEIV, USB_EHCI_HCD, USB_EHCI_HCD_OMAP
and the smsc95xx driver.

If you can paste your full kernel boot log we can check if all these show up
before the kernel tries to look up for the NFS server.
> 
> Is this a known issue on the Beagleboard? Do you have any ideas what
> might cause such an issue (unreliable USB connection, hangup of NFS
> mounting)? Any hints/links appretiated.
> 

I have been too lazy to setup NFS :). But I will give it a shot soon to see what's going
wrong.

cheers,
-roger
