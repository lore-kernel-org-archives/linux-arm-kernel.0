From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Dec 2015 14:56:14 -0800
Subject: [PATCH 1/3] ARM: multi_v7_defconfig: enable Rockchip io-domain
 driver
In-Reply-To: <2111669.2aeXLpXsWE@diego>
References: <2111669.2aeXLpXsWE@diego>
Message-ID: <20151222225614.GL30172@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2015 at 10:21:14PM +0100, Heiko St?bner wrote:
> The io-domain driver is necessary to notify the soc about voltages changes
> happening on supplying regulators. Probably the most important user right
> now is the mmc tuning code, where the soc needs to get notified when the
> voltage is dropped to the 1.8V point.
> 
> As this option is necessary to sucessfully tune UHS cards etc, it should
> get built in.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@collabora.com>
> ---
> When booting a Veyron-Jerry from an sd-card it got stuck, as the tuning
> failed due to the missing voltage notification and the mmc completely
> fails initialization of the card, if this happens.
> With this option enabled, I could again boot from my sd-card.
> 
> This is based on the 

Looks cut off :)

Anyway, applied 1-3.


-Olof
