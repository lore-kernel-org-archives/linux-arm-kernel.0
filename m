From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Jun 2017 13:59:43 +0200
Subject: [PATCH] tee: add forward declaration for struct device
In-Reply-To: <8f026b3a-9b5f-f819-817e-db812a02c129@linaro.org>
References: <6344683a299d05692ed64ddb963343ea9547add4.1496229347.git.jerome.forissier@linaro.org>
 <2bcbf7b0-7dba-7e72-72fd-4da922e442bb@linaro.org> <20170614094610.GA12598@jax>
 <CAK8P3a05K_POUxrNcyA7LVGB5qGBKmzvp-++TcLVFB2JWDdseA@mail.gmail.com>
 <8f026b3a-9b5f-f819-817e-db812a02c129@linaro.org>
Message-ID: <CAK8P3a1--+tTbe3TXLjdBP2e85_3294_MTDUy2Y5ceQ7eOOHnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 1:06 PM, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
> On 06/14/2017 01:01 PM, Arnd Bergmann wrote:
>> On Wed, Jun 14, 2017 at 11:46 AM, Jens Wiklander
>> <jens.wiklander@linaro.org> wrote:
>>> On Wed, Jun 14, 2017 at 11:39:50AM +0200, Jerome Forissier wrote:
>>>> [+Arnd]
>>>>
>>>> Ping?
>>>>
>>>> Thanks,
>>>> --
>>>> Jerome
>>>>
>>>> On 05/31/2017 01:21 PM, Jerome Forissier wrote:
>>>>> tee_drv.h references struct device, but does not include device.h nor
>>>>> platform_device.h. Therefore, if tee_drv.h is included by some file
>>>>> that does not pull device.h nor platform_device.h beforehand, we have a
>>>>> compile warning. Fix this by adding a forward declaration.
>>>>>
>>>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Do we need this to fix a warning in mainline, in linux-next, or only
>> in combination with some other patches?
>
> Only with some other patches.

Ok, in that case, Jens can just queue up the patch in his tree now,
and it will be there in time when other patches get applied on top,
no need to have this in arm-soc by itself.

Thanks,

        Arnd
