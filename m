From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 10 Dec 2014 09:44:15 +0530
Subject: [PATCH RFT 1/2] drivers: bus: check cci device tree node status
In-Reply-To: <CAM4voakjWgnEXoXT1LH2ZFBy=U4vfXFXS1Su8VB7Cd3s3wqmSA@mail.gmail.com>
References: <1417186209-5256-1-git-send-email-a.kesavan@samsung.com>
 <CAM4voakjWgnEXoXT1LH2ZFBy=U4vfXFXS1Su8VB7Cd3s3wqmSA@mail.gmail.com>
Message-ID: <5487C897.9050405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abhilash,

On Wednesday 10 December 2014 09:31 AM, Abhilash Kesavan wrote:
> Hi,
>
> On Fri, Nov 28, 2014 at 8:20 PM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
>> The arm-cci driver completes the probe sequence even if the cci node is
>> marked as disabled. Add a check in the driver to honour the cci status
>> in the device tree.
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>
> This patch helps disable CCI on the Arndale Octa board thus resolving
> some imprecise aborts seen on that board. Kindly review.
>
> Regards,
> Abhilash
>> ---
>>   drivers/bus/arm-cci.c |    3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
>> index 860da40..0ce5e2d 100644
>> --- a/drivers/bus/arm-cci.c
>> +++ b/drivers/bus/arm-cci.c
>> @@ -1312,6 +1312,9 @@ static int cci_probe(void)
>>          if (!np)
>>                  return -ENODEV;
>>
>> +       if (!of_device_is_available(np))
>> +               return -ENODEV;
>> +

IIUC, by this change you are disabling the MCPM boot protocol here.
Is there any alternative boot protocol that works on this platform
to boot all 8 cores ? Sorry by quick grep couldn't find one, hence
so I am asking.

Regards,
Sudeep
