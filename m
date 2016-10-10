From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Oct 2016 15:31:45 +0100
Subject: [PATCH RESEND] ARM: dts: keystone-k2*: Increase SPI Flash
 partition size for U-Boot
In-Reply-To: <20161010141141.21333-1-vigneshr@ti.com>
References: <20161010141141.21333-1-vigneshr@ti.com>
Message-ID: <20161010143144.GB1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2016 at 07:41:41PM +0530, Vignesh R wrote:
> U-Boot SPI Boot image is now more than 512KB for Keystone2 devices and
> cannot fit into existing partition. So, increase the SPI Flash partition
> for U-Boot to 1MB for all Keystone2 devices.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
> 
> This was submitted to v4.9 merge window but was never picked up:
> https://patchwork.kernel.org/patch/9135023/

I think you need to explain why it's safe to change the layout of the
flash partitions like this.

- What is this "misc" partition?

- Why is it safe to move the "misc" partition in this way?

- Do users need to do anything with data stored in the "misc" partition
  when changing kernels?

If the "misc" partition is simply unused space on the flash device, why
list it in DT?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
