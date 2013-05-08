From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 8 May 2013 09:56:08 +0300
Subject: [PATCHv2 0/2] Add support for the Solomon SSD1306 OLED Controller
In-Reply-To: <1366624555-5616-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1366624555-5616-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <5189F708.1040508@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/04/13 12:55, Maxime Ripard wrote:
> Hi,
> 
> This patchset adds the needed bits to the ssd1307fb driver to support the
> very similar Solomon SSD1306 controller.
> 
> Since the SSD1307 has been replaced by the SSD1306 in the latest CFA-10036
> production samples, we also need to change the device tree accordingly.
> 
> Thanks,
> Maxime
> 
> Changes from v1:
>   - Fix style errors
> 
> Maxime Ripard (2):
>   video: ssd1307fb: Add support for SSD1306 OLED controller
>   ARM: dts: cfa10036: Change the OLED display to SSD1306
> 
>  .../devicetree/bindings/video/ssd1307fb.txt        |   10 +-
>  arch/arm/boot/dts/imx28-cfa10036.dts               |   14 +-
>  arch/arm/boot/dts/imx28-cfa10049.dts               |    4 +-
>  drivers/video/ssd1307fb.c                          |  273 +++++++++++++++-----
>  4 files changed, 216 insertions(+), 85 deletions(-)

I've taken the first patch, "video: ssd1307fb: Add support for SSD1306
OLED controller" into fbdev 3.11 branch. The dts changes should
preferably go through arch tree.

 Tomi



-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130508/0bf96a45/attachment.sig>
