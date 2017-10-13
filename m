From: jeffy.chen@rock-chips.com (jeffy)
Date: Fri, 13 Oct 2017 18:47:18 +0800
Subject: [PATCH 1/2] spi: rockchip: Convert to late and early system PM
 callbacks
In-Reply-To: <20171013101719.bophbiz7qb5wi7n2@sirena.co.uk>
References: <20171013100116.8271-1-jeffy.chen@rock-chips.com>
 <20171013101719.bophbiz7qb5wi7n2@sirena.co.uk>
Message-ID: <59E099B6.1000804@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 10/13/2017 06:17 PM, Mark Brown wrote:
> On Fri, Oct 13, 2017 at 06:01:15PM +0800, Jeffy Chen wrote:
>> Currently we are suspending the spi master in it's ->suspend callback,
>> which is racy as some other drivers may still want to transmit messages
>> on the bus(e.g. spi based pwm backlight).
>
> I'm missing patch 2/2.
>
Sorry, i'll resend them...

This patch is to defer suspend_spi_master to late suspend.

Since we put display-subsystem dt node above spi dt node, which makes 
spi suspend been called before display driver. Then the display driver 
would fail to set pwm backlight through spi in it's suspend/resume.
