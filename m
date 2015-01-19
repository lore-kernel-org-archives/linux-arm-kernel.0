From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 19 Jan 2015 14:38:56 +0100
Subject: [PATCHv10 0/2] Add Allwinner SoCs PWM support
In-Reply-To: <1418850940-30835-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1418850940-30835-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150119133855.GB23778@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 10:15:38PM +0100, Alexandre Belloni wrote:
> Hi,
> 
> This patch series adds support for the PWM controller found on the Allwinner
> SoCs.
> 
> The first patch adds the driver itself.
> The second patch adds the DT binding documentation
> 
> Changes in v8:
>  - renamed the driver sun4i as the PWM IP is different in the next sunxi SoCs
>  - Took into account comments from Thierry
> 
> Changes in v9:
>  - moved from using a mutex to a spinlock
> 
> Changes in v10:
>  - rebased on v3.18
>  - corrected the module name in Kconfig
>  - Added dependancy on HAS_IOMEM and COMMON_CLK
>  - changes clk_rate in sun4i_pwm_config() to be a u64 to avoid unnecessary
>    casting
>  - removed unnecessary braces
> 
> Alexandre Belloni (2):
>   pwm: Add Allwinner SoC support
>   pwm: sunxi: document OF bindings
> 
>  .../devicetree/bindings/pwm/pwm-sun4i.txt          |  20 ++
>  drivers/pwm/Kconfig                                |  10 +
>  drivers/pwm/Makefile                               |   1 +
>  drivers/pwm/pwm-sun4i.c                            | 366 +++++++++++++++++++++
>  4 files changed, 397 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
>  create mode 100644 drivers/pwm/pwm-sun4i.c

I've applied this series. If anyone still wants to offer a Tested-by or
Reviewed-by, hurry up.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150119/7112e8c3/attachment-0001.sig>
