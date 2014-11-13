From: tj@kernel.org (Tejun Heo)
Date: Thu, 13 Nov 2014 17:29:52 -0500
Subject: [PATCH] ahci_sunxi: Drop AHCI_HFLAG_NO_PMP flag
In-Reply-To: <1415874256-6580-1-git-send-email-hdegoede@redhat.com>
References: <1415874256-6580-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20141113222952.GI2598@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 11:24:16AM +0100, Hans de Goede wrote:
> This is something which we inherited from the Allwinner android kernel sources,
> and I've always wanted to test if this is really necessary.
> 
> So recently I've bought a sata port multiplexer, and I've given this a test
> spin on both A10 and A20 devices, and it seems to work fine:
> 
> [    2.154456] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    2.161092] ata1.15: Port Multiplier 1.2, 0x197b:0x0325 r0, 5 ports, feat 0x5/0xf
> [    2.175511] ata1.00: hard resetting link
> [    2.524929] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
> [    2.531430] ata1.01: hard resetting link
> [    2.974465] ata1.01: link resume succeeded after 1 retries
> [    3.094932] ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    3.101431] ata1.02: hard resetting link
> [    4.174466] ata1.02: failed to resume link (SControl 0)
> [    4.180065] ata1.02: SATA link down (SStatus 0 SControl 0)
> (and the same for links 3 and 4)
> 
> Once the NO_PMP flag is removed it correctly sees the 2 disks which I've
> attached, and I can mount and use them just fine, so lets drop the flag.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to libata/for-3.18-fixes.

Thanks.

-- 
tejun
