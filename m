From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Nov 2016 16:13:31 +0000
Subject: [PATCH 0/8] firmware: arm_scpi: add support for legacy SCPI
 protocol
In-Reply-To: <e83e8462-6d63-7253-f69c-afb507463bba@arm.com>
References: <1478148731-11712-1-git-send-email-sudeep.holla@arm.com>
 <20161108145118.GR1041@n2100.armlinux.org.uk>
 <28decdc3-6b86-924f-d3c1-9873a8cfce77@arm.com>
 <20161108154038.GS1041@n2100.armlinux.org.uk>
 <e83e8462-6d63-7253-f69c-afb507463bba@arm.com>
Message-ID: <20161108161331.GV1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 04:08:38PM +0000, Sudeep Holla wrote:
> I will focus on this and see what's happening. I have issue with network
> on my setup with debug build and Linaro guys are not seeing it. I revert
> to release build of UEFI for that. Anyways one suggestion I have right
> now is to erase the second partition of NOR flash where the old UEFI
> config is placed and it could be conflicting with the new UEFI image.
> 
> Cmd> flash
> 
> 
> Switching on main power...
> PMIC RAM configuration (pms_v105.bin)...
> IOFPGA config: PASSED
> Enabling usb remote...
> 
> 
> Flash> ERASERANGE 0x0BFC0000 0x0BFF0000
> 
> I will looking into that further.

Still behaves the same, stopping at:

FV2 Hob           0xFE07B000 - 0xFE8253BF


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
