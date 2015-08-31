From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Mon, 31 Aug 2015 10:44:40 +0200
Subject: [PATCH 3/7] dmaengine: st_fdma: Add STMicroelectronics FDMA
 engine driver support
In-Reply-To: <1441008481.8272.10.camel@tiscali.nl>
References: <1436371888-27863-1-git-send-email-peter.griffin@linaro.org>
 <1436371888-27863-4-git-send-email-peter.griffin@linaro.org>
 <1436429872.20619.77.camel@tiscali.nl> <55E40715.1040204@st.com>
 <1441008481.8272.10.camel@tiscali.nl>
Message-ID: <55E413F8.6070307@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/31/2015 10:08 AM, Paul Bolle wrote:
> Hi Maxime,
>
> On ma, 2015-08-31 at 09:49 +0200, Maxime Coquelin wrote:
>> On 07/09/2015 10:17 AM, Paul Bolle wrote:
>>>>> +static int __exit st_fdma_remove(struct platform_device *pdev)
>>>>> +{
>>>>> +	struct st_fdma_dev *fdev = platform_get_drvdata(pdev);
>>>>> +
>>>>> +	wait_for_completion(&fdev->fw_ack);
>>>>> +
>>>>> +	st_fdma_clk_disable(fdev);
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>> Since this driver is built-in only this means st_fdma_remove() can
>>> never be used, right?
>> It's not because a driver is built-in only that it does not need a
>> remove callback.
>> An instance can be probed/removed any time via driver's bind/unbind
>> SysFS entries.
>> Am I missing something?
> (This discussion is moot because Peter already stated that a new version
> will be modular.)
>
> It follows from the __exit tag that st_fdma_remove() should never be
> part of the kernel image (in this version of the patch), doesn't it?
Yes, you are right.
The remove callback is relevant, but without the __exit tag.
>
> (I don't know what happens in this situation if an unbind sysfs entry is
> used to remove a driver. I've never tried that.)
>
>
Not checked whether the function is omitted when built-in, but in any 
case, I thnk remove callbacks should not be tagged with __exit.

Regards,
Maxime
