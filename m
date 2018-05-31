From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 31 May 2018 15:16:20 -0700
Subject: [PATCH v2 1/2] ARM: debug: Add Iproc UART3 debug addresses
In-Reply-To: <41bbf801-f060-2056-4015-b4d05c6831bb@broadcom.com>
References: <20180530131956.13972-1-peron.clem@gmail.com>
 <93c2d07a-9344-ed39-261e-11084067a3fa@broadcom.com>
 <CAJiuCcek9KU6QWsAAxVCLUaf1v97uR6FcLOfY=A1LGCMTmjHjg@mail.gmail.com>
 <41bbf801-f060-2056-4015-b4d05c6831bb@broadcom.com>
Message-ID: <61a35071-4304-a25f-8c99-fe504b2c2346@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/31/2018 10:24 AM, Ray Jui wrote:
> 
> 
> On 5/31/2018 1:22 AM, Cl?ment P?ron wrote:
>> Hi Rai,
>>
>> On Wed, 30 May 2018 at 19:25, Ray Jui <ray.jui@broadcom.com> wrote:
>>>
>>> Hi Cl?ment,
>>>
>>> Correct me if I'm wrong, but I thought the trend is to move to use
>>> earlycon that can be activated from kernel command line for early print
>>> before the serial driver is loaded.
>>>
>>> Have you tried earlcon?
>> No, only tested this method.
>>
>> Thanks,
>> Clement
>>
> 
> If I remember it correctly, I think the trend is to use earlycon. There
> are obvious shortcomings by making this configuration compile time based.

This is true, though on ARM 32-bit kernels DEBUG_LL gets used by the
kernel self-decompressor and also before earlycon has a chance to run,
this is useful to debugging memory issues where your memory
configuration is incorrect typically.

Either way is fine with me (accepting or dropping) the patch, though
there is probably minimal impact in just accepting such a change.

-- 
Florian
