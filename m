From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 14 Nov 2012 14:30:08 +0800
Subject: [PATCH v5 1/3] ARM: at91: atmel-ssc: add pinctrl support
In-Reply-To: <20121113085052.GR18224@opensource.wolfsonmicro.com>
References: <1352706028-750-1-git-send-email-voice.shen@atmel.com>
 <1352706028-750-2-git-send-email-voice.shen@atmel.com>
 <20121113085052.GR18224@opensource.wolfsonmicro.com>
Message-ID: <50A33A70.1030705@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 11/13/2012 16:50, Mark Brown wrote:
> On Mon, Nov 12, 2012 at 03:40:25PM +0800, Bo Shen wrote:
>
>> +				ssc0 {
>> +					pinctrl_ssc0_tx: ssc0_tx-0 {
>> +						atmel,pins =
>> +							<1 16 0x1 0x1	/* PB16 periph A with pull up */
>> +							 1 17 0x1 0x1	/* PB17 periph A with pull up */
>> +							 1 18 0x1 0x1>;	/* PB18 periph A with pull up */
>> +					};
>
> Do we really want the pull ups here?  Normally CMOS devices don't have
> pulls, or the pulls are disabled during normal operation, as otherwise
> when the logic level is different to whatever the pull is doing power is
> wasted driving against the resistor.

After checking with internal, it does not need pull up. I will correct 
this in next version.

Thanks.

Best Regards,
Bo Shen
