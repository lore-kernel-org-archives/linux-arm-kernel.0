From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Fri, 17 Mar 2017 08:27:08 -0600
Subject: [PATCH] usb: dwc3 dwc3_exynos_probe() change goto labels to
 meaningful names
In-Reply-To: <CAFp+6iEQxO7HcW5xJscc9ZWkTy+LoDm7AiNsK8YOd_S3okOGfg@mail.gmail.com>
References: <20170130192504.19046-1-shuahkh@osg.samsung.com>
 <CAFp+6iEQxO7HcW5xJscc9ZWkTy+LoDm7AiNsK8YOd_S3okOGfg@mail.gmail.com>
Message-ID: <3abd0519-3435-4cd4-2c64-6d648aed944b@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/17/2017 12:24 AM, Vivek Gautam wrote:
> On Tue, Jan 31, 2017 at 12:55 AM, Shuah Khan <shuahkh@osg.samsung.com> wrote:
>> Change goto labels to meaningful names from a series of errNs.
>>
>> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
>> ---
>>
>> Rebased to usb-next
>>
>>  drivers/usb/dwc3/dwc3-exynos.c | 22 +++++++++++-----------
>>  1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
>> index 1515d45..98f74ff 100644
>> --- a/drivers/usb/dwc3/dwc3-exynos.c
>> +++ b/drivers/usb/dwc3/dwc3-exynos.c
>> @@ -147,53 +147,53 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>>         exynos->vdd33 = devm_regulator_get(dev, "vdd33");
>>         if (IS_ERR(exynos->vdd33)) {
>>                 ret = PTR_ERR(exynos->vdd33);
>> -               goto err2;
>> +               goto vdd33_err;
> 
> While you are changing this in probe, care to change in
> dwc3_exynos_register_phys() as well ?

Yes I can do that.

> 
> [snip]
> 
> Regards
> Vivek

thanks,
-- Shuah
