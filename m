From: xerofoify@gmail.com (nick)
Date: Thu, 06 Aug 2015 21:31:42 -0400
Subject: [PATCH] kvm:arm:Fix error handling in the function vgic_v3_probe
In-Reply-To: <CAJKOXPeVGmrkBwRRY6D46MhXtWH+_ybxyJpQjyH4F7BOpKLxSQ@mail.gmail.com>
References: <1438793303-30228-1-git-send-email-xerofoify@gmail.com>	<55C240D9.5060900@redhat.com>	<55C242C6.6060200@gmail.com>	<55C31582.4000809@arm.com>	<55C34C77.7090303@redhat.com>	<55C35E3D.9000708@gmail.com>
 <CAJKOXPeVGmrkBwRRY6D46MhXtWH+_ybxyJpQjyH4F7BOpKLxSQ@mail.gmail.com>
Message-ID: <55C40A7E.6040003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015-08-06 08:47 PM, Krzysztof Kozlowski wrote:
> 2015-08-06 22:16 GMT+09:00 nick <xerofoify@gmail.com>:
>>
>>
>> On 2015-08-06 08:00 AM, Paolo Bonzini wrote:
>>>
>>>
>>> On 06/08/2015 10:06, Marc Zyngier wrote:
>>>>> If this structure of function pointers can handle function pointers with a return type of
>>>>> void I will be glad to do what you request otherwise this would require a major rewrite
>>>>> of kvm arm subsystem for a very simple bug fix.
>>>>
>>>> Just like Paolo said, the error you report should never happen, and
>>>> would be caught by a WARN_ON() the first time anyone boots the kernel.
>>>> Also, failing to register the device ops results in not being able to
>>>> instantiate a VGIC. No harm done. I really don't understand why you want
>>>> to rewrite the probe functions.
>>>
>>> I think he just misunderstood my suggestion.  I didn't suggest making
>>> the probe functions return void.  I suggested that
>>> kvm_register_device_ops return void.
>>>
>>> Paolo
>>>
>> Unfortunately the other maintainer is right in the s390 kvm subsystem uses the return value of the call to
>> kvm_register_device_ops. However we could do something like a WARN_ON if kvm_register_device_ops fails in
>> callers that never are required to never use it's return value.
>> Sorry about the Misunderstanding as I misread your suggestion.
>> Nick
> 
> Dear Nick,
> 
> Since you are not testing the patches, please always mark them with
> RFT prefix, instead of PATCH. Someone may get confused and actually
> apply untested patch.
> 
> Best regards,
> Krzysztof
> 
Krzysztof,
I am not stating your wrong here but most of my patches are either trivial bug fixes that
don't need any testing or our on hardware I don't have lying around. In addition unless
my bugs are hard to trace a.k.a locking issues or hardware dependent that need proof due
to being unable to trace without the hardware I feel that your statement is a valid idea
but may not be the best here. If you would like me to still write RFT on my patches or
our concerned about me testing them I can assure you that there tested when I am able
to.
Cheers,
Nick 
