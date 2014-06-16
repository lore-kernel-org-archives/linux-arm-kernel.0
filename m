From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 16 Jun 2014 10:54:58 +0200
Subject: [PATCH 3/5] clk: Add driver for Maxim 77802 PMIC clocks
In-Reply-To: <20140616084427.GG14323@lee--X1>
References: <1402306670-17041-1-git-send-email-javier.martinez@collabora.co.uk>
 <1402306670-17041-4-git-send-email-javier.martinez@collabora.co.uk>
 <20140616084427.GG14323@lee--X1>
Message-ID: <539EB0E2.1080307@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lee,

On 06/16/2014 10:44 AM, Lee Jones wrote:
>> The MAX77802 PMIC has two 32.768kHz Buffered Clock Outputs with
>> Low Jitter Mode. This patch adds support for these two clocks.
>> 
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>>  .../devicetree/bindings/clock/maxim,max77802.txt   |  40 ++++
>>  drivers/clk/Kconfig                                |   6 +
>>  drivers/clk/Makefile                               |   1 +
>>  drivers/clk/clk-max77802.c                         | 253 +++++++++++++++++++++
>>  drivers/mfd/max77802.c                             |   3 +
>>  include/dt-bindings/clock/maxim,max77802.h         |  22 ++
>>  6 files changed, 325 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/maxim,max77802.txt
>>  create mode 100644 drivers/clk/clk-max77802.c
>>  create mode 100644 include/dt-bindings/clock/maxim,max77802.h
> 
> [...]
> 
>> diff --git a/drivers/mfd/max77802.c b/drivers/mfd/max77802.c
>> index 59696dd..33e8023 100644
>> --- a/drivers/mfd/max77802.c
>> +++ b/drivers/mfd/max77802.c
>> @@ -35,6 +35,9 @@
>>  
>>  static const struct mfd_cell max77802_devs[] = {
>>  	{ .name = "max77802-pmic", },
>> +#if defined(CONFIG_COMMON_CLK_MAX77802)
> 
> No, don't do that.  If COMMON_CLK_MAX77802 is not defined it just
> won't be matched, which is enough to ensure it won't be probed.
>

Thanks a lot for the explanation.

I'll send a v2 patch-set soon which has changes based on the feedback from Mark
and Krzysztof. I'll take this point into account as well.

>> +	{ .name = "max77802-clk", },
>> +#endif
>>  };
> 
> [...]
> 

Best regards,
Javier
