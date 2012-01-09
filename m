From: omaplinuxkernel@gmail.com (Shubhrajyoti Datta)
Date: Mon, 9 Jan 2012 17:00:45 +0530
Subject: [PATCH RFC] MFD: OMAP: USB: Make the runtime functions depend on
 CONFIG_PM_RUNTIME
In-Reply-To: <874nwc8gts.fsf@ti.com>
References: <1325572979-6090-1-git-send-email-shubhrajyoti@ti.com>
 <874nwc8gts.fsf@ti.com>
Message-ID: <CAM=Q2csKSgvTrEyJn_nJRyphn-T0EkWwp3k5CKzL8TQMoDRZQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 4, 2012 at 5:44 AM, Kevin Hilman <khilman@ti.com> wrote:
> Shubhrajyoti D <shubhrajyoti@ti.com> writes:
>
>> Currently the runtime functions are compiled regardless
>> of CONFIG_PM_RUNTIME flag. This patch intends to fix the same by
>> using SET_RUNTIME_PM_OPS.
>>
>> Cc : Keshava Munegowda <keshava_mgowda@ti.com>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>> ---
>> applies on Tony's ehci branch.
>> Compile tested only.
>
> You also should compile test this with runtime PM disabled. ?I believe
> the current patch will lead to 'function defined but not used' warnings.

Agree . thanks for pointing out.

>
> Kevin
>
>> ?drivers/mfd/omap-usb-host.c | ? ?4 ++--
>> ?1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
>> index 3f565ef..ef72ebe 100644
>> --- a/drivers/mfd/omap-usb-host.c
>> +++ b/drivers/mfd/omap-usb-host.c
>> @@ -887,8 +887,8 @@ static int __devexit usbhs_omap_remove(struct platform_device *pdev)
>> ?}
>>
>> ?static const struct dev_pm_ops usbhsomap_dev_pm_ops = {
>> - ? ? .runtime_suspend ? ? ? ?= usbhs_runtime_suspend,
>> - ? ? .runtime_resume ? ? ? ? = usbhs_runtime_resume,
>> + ? ? SET_RUNTIME_PM_OPS(usbhs_runtime_suspend,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? usbhs_runtime_resume, NULL)
>> ?};
>>
>> ?static struct platform_driver usbhs_omap_driver = {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
