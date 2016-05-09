From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 9 May 2016 13:28:14 +0100
Subject: [PATCH V2 3/3] nvmem: imx-ocotp: handling clock
In-Reply-To: <1461173177-11930-3-git-send-email-van.freenix@gmail.com>
References: <1461173177-11930-1-git-send-email-van.freenix@gmail.com>
 <1461173177-11930-3-git-send-email-van.freenix@gmail.com>
Message-ID: <5730825E.5030101@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the Ping, I totally missed this thread.

On 20/04/16 18:26, Peng Fan wrote:
> Before access ocotp nvmem area, the clock should be enabled.
> Or, `hexdump nvmem` will hang the system. So, use such flow:
> "
>    1. clock_enable_prepare
>    2. read nvmem ocotp area
>    3. clock_disable_unprepare
> "
>
> Signed-off-by: Peng Fan <van.freenix@gmail.com>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> ---
>
> V2:
>   Follow Fabio's comments, check return value of clk_prepare_enable
>
>   drivers/nvmem/imx-ocotp.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)

Changes to the driver looks good to me,
Only one comment, As the clock property is now made mandatory, you 
should update the dt-bindings with this info too.


thanks,
srini
