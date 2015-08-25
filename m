From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue, 25 Aug 2015 14:08:26 +0530
Subject: [PATCH-v2 5/5] mfd: 88pm800: Add support for clk subdevice
In-Reply-To: <20150825074924.GD19409@x1>
References: <1440442594-3102-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1440442594-3102-7-git-send-email-vaibhav.hiremath@linaro.org>
 <55DBFC40.3010603@samsung.com> <20150825074924.GD19409@x1>
Message-ID: <55DC2982.5010906@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 25 August 2015 01:19 PM, Lee Jones wrote:
> On Tue, 25 Aug 2015, Krzysztof Kozlowski wrote:
>
>> On 25.08.2015 03:56, Vaibhav Hiremath wrote:
>>> This patch adds mfd_cell/clk-subdevice for 88PM800 MFD
>>> (and family of devices).
>>>
>>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>>> ---
>>>   drivers/mfd/88pm800.c | 25 +++++++++++++++++++++++++
>>>   1 file changed, 25 insertions(+)
>>>
>>> diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
>>> index c4e097d..a928eed 100644
>>> --- a/drivers/mfd/88pm800.c
>>> +++ b/drivers/mfd/88pm800.c
>>> @@ -173,6 +173,14 @@ static const struct mfd_cell regulator_devs[] = {
>>>   	},
>>>   };
>>>
>>> +static struct mfd_cell clk_devs[] = {
>>> +	{
>>> +		.name = "88pm80x-clk",
>>> +		.of_compatible = "marvell,88pm800-clk",
>>> +		.id = -1,
>>
>> The "-1" here stands for PLATFORM_DEVID_NONE?
>
> Right.  Please use the define, but use it in the mfd_add_devices()
> call, rather than individual cells.
>

Ok,

Thanks,
Vaibhav
