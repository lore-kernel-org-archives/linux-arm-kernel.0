From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 1 Nov 2016 15:56:17 +0530
Subject: [PATCH v2 5/5] ARM: dts: da850-lcdk: add tilcdc panel node
In-Reply-To: <1477925138-23457-6-git-send-email-bgolaszewski@baylibre.com>
References: <1477925138-23457-1-git-send-email-bgolaszewski@baylibre.com>
 <1477925138-23457-6-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <3e8671aa-e59d-4595-c323-af9e6a0ad615@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 31 October 2016 08:15 PM, Bartosz Golaszewski wrote:
> The tilcdc driver is not yet ready for working together with the
> dumb-vga-dac drm bridge. While the work on enabling drm_bridge
> support in tilcdc continues, enable the VGA connector on da850-lcdk
> with the following workaround: use the tilcdc-panel driver with
> a set of common (and tested) resolutions.
> 
> Once the drm bridge support is complete, we'll remove the node added
> by this patch and use the correct solution. This change will be
> transparent for the user.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I dont think this can be applied. If this goes in v4.10, then the DT
blob becomes an ABI and driver will have to support tilcdc-panel driver
for DA850 forever.

Its probably better to wait for the proper driver support to arrive.

Thanks,
Sekhar
