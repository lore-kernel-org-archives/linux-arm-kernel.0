From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 16 Jul 2014 02:35:56 +0900
Subject: [PATCH v3 1/2] ARM: dts: Add mask-tpm-reset to the device tree
In-Reply-To: <CAD=FV=XJD=Dt8z5Vmy2wXs4_FWqiW3=AhVw=sSZXFxv31+FHhA@mail.gmail.com>
References: <1405420294-9323-1-git-send-email-vikas.sajjan@samsung.com>
 <1405420294-9323-2-git-send-email-vikas.sajjan@samsung.com>
 <CAD=FV=XJD=Dt8z5Vmy2wXs4_FWqiW3=AhVw=sSZXFxv31+FHhA@mail.gmail.com>
Message-ID: <53C5667C.9070207@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/14 01:19, Doug Anderson wrote:
> Vikas,
>
> On Tue, Jul 15, 2014 at 3:31 AM, Vikas Sajjan<vikas.sajjan@samsung.com>  wrote:
>> From: Doug Anderson<dianders@chromium.org>
>>
>> The mask-tpm-reset GPIO is used by the kernel to prevent the TPM from
>> being reset across sleep/wake.  If we don't set it to anything then
>> the TPM will be reset.  U-Boot will detect this as invalid
>> and will reset the system on resume time. This GPIO can always be low
>> and not hurt anything.  It will get pulled back high again during a
>> normal warm reset when it will default back to an input.
>>
>> To properly preserve the TPM state across suspend/resume and to make
>> the chrome U-Boot happy, properly set the GPIO to mask the
>> reset to the TPM.
>>
>> Signed-off-by: Doug Anderson<dianders@chromium.org>
>> Signed-off-by: Vikas Sajjan<vikas.sajjan@samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos5420-peach-pit.dts |   12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>
> Looks good to me.  I'll assume Kukjin will add the words
> "exynos5420-peach-pit" into the patch description when applying.
>
Yes :)

> Reviewed-by: Doug Anderson<dianders@chromium.org>
>
I've applied this series, thanks.

- Kukjin
