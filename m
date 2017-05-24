From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 24 May 2017 17:45:51 +0200
Subject: [PATCH v2] ARM: dts: rockchip: add eDP panel support for Firefly
In-Reply-To: <20170508155833.19652-1-ayaka@soulik.info>
References: <20170508155833.19652-1-ayaka@soulik.info>
Message-ID: <1982494.aeoIls14E7@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Randy,

Am Montag, 8. Mai 2017, 23:58:33 CEST schrieb Randy Li:
> This patch adds the supporting to the eDP panel sold by
> the T-CHIP for the Firefly RK3288. I assign the VOP lite
> for the eDP panel and VOP big to HDMI, as the HDMI supports
> 4K resolution. With a different VOP device, eDP panel
> and HDMI could display a different contents.
> 
> The InvenSense MPU6050 sensor at the botton of the panel
> is also enabled.
> 
> The Firefly RK3288 Reload use a different GPIO pin to enable
> the power of the eDP panel.
> 
> Signed-off-by: Randy Li <ayaka@soulik.info>

Sorry, I'm not yet sure, what to make of this patch.

On the firefly the edp pins are actual part of the general pin header and
while the edp pins themself do not have multiple functions, for example
the pin you claim as interrupt for the mpu6050 (gpio5_b4) also is part
of the spi0 set of pins and that pin also seems pretty randomly selected.
Same with the enable-gpio of the display.


Also claiming that every firefly board has this display connected also
feels strange and the whole display thing would make more sense
as a devicetree overlay [0], though I don't know how these
should get handled in-kernel - if at all.


And finally, please don't try to use the devicetree to configure outputs
(forcing edp to one and hdmi to the other). The devicetree is supposed
to describe the hardware and of course both vops can drive the edp and
if necessary the drm driver should handle differences and decide on the
vop to use.


Heiko

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/overlay-notes.txt
