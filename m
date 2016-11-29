From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Tue, 29 Nov 2016 10:10:58 +0000
Subject: [PATCH] extcon: Split out the extcon APIs for extcon provider
 driver
In-Reply-To: <1480413743-13037-1-git-send-email-cw00.choi@samsung.com>
References: <1480413743-13037-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <20161129101058.GG1867@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2016 at 07:02:23PM +0900, Chanwoo Choi wrote:
> This patchs split out the extcon APIs of extcon provider driver in order to
> prevent the direct access of struct extcon_dev by extcon consumer driver.
> The extcon consumer driver don't need to handle the extcon provider APIs.
> 
> The extcon subsystem has two type of extcon drivers as following:
> - extcon provider driver
> : Detect the external connector and identify the state/property of
>   each external connector. And it send the notification to synchronize
>   the information between provider and consumer driver.
> - extcon consumer driver
> : Receive the notifcation from extcon provider driver. When receving the noti,
>   it can get the both state and property of specific external connector.
> 
> Cc: Myungjoo Ham <myungjoo.ham@samsung.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Chris Zhong <zyw@rock-chips.com>
> Cc: Roger Quadros <rogerq@ti.com>
> Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Cc: patches at opensource.wolfsonmicro.com
> Cc: linux-renesas-soc at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-usb at vger.kernel.org
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/extcon/devres.c                |   2 +-
>  drivers/extcon/extcon-adc-jack.c       |   2 +-
>  drivers/extcon/extcon-arizona.c        |   2 +-

For the Arizona bit:

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
