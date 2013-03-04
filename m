From: hechtb@gmail.com (Bastian Hecht)
Date: Mon, 4 Mar 2013 16:46:51 +0100
Subject: [PATCH 3/3] ARM: mach-shmobile: sh73a0: Setup the timer device
 CMT10 using DT
In-Reply-To: <5130FEB9.5000508@cogentembedded.com>
References: <1362159932-18533-1-git-send-email-hechtb+renesas@gmail.com>
 <1362159932-18533-4-git-send-email-hechtb+renesas@gmail.com>
 <5130FEB9.5000508@cogentembedded.com>
Message-ID: <CABYn4sxkaGzyL7qtaQCKp6Qy=ExOR+5cLgvWS8pL_gQeZKgKtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2013/3/1 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>:
> Hello.
>
>
> On 03/01/2013 08:45 PM, Bastian Hecht wrote:
>
>> We can now use the Device Tree for bringing up our timer device CMT10.
>> We move it out of the DT devices list into the early_devices list by
>> the non-reference board code. And we add the device to the
>> kzm9g-reference .dts file.
>>
>> Not-yet-signed-off-by: Bastian Hecht<hechtb+renesas@gmail.com>
>> ---
>> I wonder if this should go to arch/arm/boot/dts/sh73a0.dtsi.
>>
>> The moving to the early_devices is a bit hackish - I will cook up a better
>> patch when I know into which .dts(i) file things go.
>>
>>   arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |   11 +++++++++++
>>   arch/arm/mach-shmobile/setup-sh73a0.c        |    2 +-
>>   2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
>> b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
>> index 7fad4b9..fef12f0 100644
>> --- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
>> +++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
>> @@ -69,6 +69,17 @@
>>                 toshiba,mmc-wrprotect-disable;
>>                 toshiba,mmc-has-idle-wait;
>>         };
>> +
>> +       cmt at 0xe6138010 {
>>
>
>
>     "0x" shouldn't be there, remove it please.
>
> WBR, Sergei
>

Thanks for pointing out this one. Fixed it in another patchset as well.

Bastian
