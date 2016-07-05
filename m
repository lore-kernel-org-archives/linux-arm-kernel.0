From: gabriel.fernandez@st.com (Gabriel Fernandez)
Date: Tue, 5 Jul 2016 09:29:46 +0200
Subject: [PATCH 3/4] drivers: reset: Add STM32 reset driver
In-Reply-To: <1467653810.2224.77.camel@pengutronix.de>
References: <1467640052-6770-1-git-send-email-gabriel.fernandez@st.com>
 <1467640052-6770-3-git-send-email-gabriel.fernandez@st.com>
 <1467653810.2224.77.camel@pengutronix.de>
Message-ID: <577B61EA.5080703@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

Thanks for reviewing.

On 07/04/2016 07:36 PM, Philipp Zabel wrote:
> Hi Gabriel,
>
> Am Montag, den 04.07.2016, 15:47 +0200 schrieb gabriel.fernandez at st.com:
>> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> Isn't Maxime the author of this driver?
Yes i upstream with his agreement.
I only made small modifications (use of devm_reset_controller_register(),
make reset_control_ops const...) that's why the author in the git 
history has
been changed... I will use g |it commit  --amend --author="Maxime.." for 
the v2.
|
>> The STM32 MCUs family IPs can be reset by accessing some registers
>> from the RCC block.
>>
>> The list of available reset lines is documented in the DT bindings.
>>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
>> ---
>>   drivers/reset/Makefile      |   1 +
>>   drivers/reset/reset-stm32.c | 113 ++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 114 insertions(+)
>>   create mode 100644 drivers/reset/reset-stm32.c
>>
>> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
>> index 03dc1bb..3776b7b 100644
>> --- a/drivers/reset/Makefile
>> +++ b/drivers/reset/Makefile
> [...]
>> +static const struct reset_control_ops stm32_reset_ops = {
>> +	.assert		= stm32_reset_assert,
>> +	.deassert	= stm32_reset_deassert,
> Are the registers not readable, or did you choose not to
> implement .status on purpose?
We choose to not implement.

Thanks!

Best Regards

Gabriel

> regards
> Philipp
>
