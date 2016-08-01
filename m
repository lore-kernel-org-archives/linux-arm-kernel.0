From: robh@kernel.org (Rob Herring)
Date: Mon, 1 Aug 2016 11:41:56 -0500
Subject: [PATCH v2] dt: bindings: Make compatible optional for mmc
 function nodes
In-Reply-To: <1469891030-28838-1-git-send-email-hdegoede@redhat.com>
References: <1469891030-28838-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160801164156.GA29075@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 30, 2016 at 05:03:50PM +0200, Hans de Goede wrote:
> On some boards (android tablets) different batches use different sdio
> wifi modules. This is not a problem since mmc/sdio is an enumerable bus,
> so we only need to describe and activate the mmc controller in dt and
> then the kernel will automatically load the right driver.
> 
> Sometimes it is useful to specify certain ethernet properties for these
> "unknown" sdio devices, specifically we want the boot-loader to be able
> to set "local-mac-address" as some of these sdio wifi modules come without
> an eeprom / without a factory programmed mac address.
> 
> Since the exact device is unknown (differs per batch) we cannot use
> a wifi-chip specific compatible, thus sometimes it is desirable to have a
> mmc function node, without having to make up an otherwise unused compatible
> for the node, so make the compatible property optional.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Change the commit-msg to explain why it sometimes is desirable to have a
>  mmc function node without a compatible
> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
