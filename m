From: zhangfei.gao@linaro.org (zhangfei)
Date: Tue, 10 Feb 2015 23:20:23 +0800
Subject: [PATCH v3 4/5] usb: phy: load usb phy earlier
In-Reply-To: <20150210144925.GD16711@saruman.tx.rr.com>
References: <20150210070424.GC32709@shlinux2>
 <20150210144925.GD16711@saruman.tx.rr.com>
Message-ID: <54DA21B7.6090306@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/10/2015 10:49 PM, Felipe Balbi wrote:
> On Tue, Feb 10, 2015 at 03:04:28PM +0800, Peter Chen wrote:
>> This patch does not belong to phy, so, doesn't need to
>> add phy in subject, meanwhile, please add GregKH as TO list,
>> he is the right one to queue this patch.
>>
>> Reply-To:
>> In-Reply-To: <1423554627-694-5-git-send-email-zhangfei.gao@linaro.org>
>>
>> On Tue, Feb 10, 2015 at 03:50:26PM +0800, Zhangfei Gao wrote:
>>> Since phy is definitely used in usb controller, load the phy
>>> earlier to make boot time shorter.
>>>
>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>>> Acked-by: Peter Chen <peter.chen@freescale.com>
>
> NAK, make sure there are no such dependencies with your controller
> driver. They should know how to defer probing if their resources aren't
> available yet.

Sorry for the confusion,
There is no dependencies at all, just for optimization.
Peter already told me this patch should not be put here, causing confusion.
And I resend in another thread.

The controller is dwc2, which use defer probe. And dwc2 controller defer 
probe every time even the phy driver in the same folder.
Since we know the calling sequence, we can simply change the sequence to 
load the phy earlier.


However, as you said the new driver will be put in drivers/phy, there 
should be no such issue in the future.
It is OK not using this patch.

Thanks
