From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 13 Jul 2015 15:29:45 +0100
Subject: Extensions for KVM MSI related ioctls
In-Reply-To: <55A3CA17.1010500@linaro.org>
References: <55A39231.4050904@arm.com> <55A3B090.6090002@redhat.com>
 <03b901d0bd70$6c2f4b50$448de1f0$@samsung.com> <55A3CA17.1010500@linaro.org>
Message-ID: <55A3CB59.80906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 13/07/15 15:24, Eric Auger wrote:
> On 07/13/2015 03:32 PM, Pavel Fedin wrote:
>>  Hello!
>>
>>> I think I prefer the flag.  Offhand it sounds easier to add support for
>>> it to non-ARM architectures, compared to KVM_IRQ_ROUTING_EXTENDED_MSI.
>>
>>  Actually i also voted for flag, because it is already introduced in (2), and i'm not a fan of
>> adding new definitions where we can reuse existing ones. IMHO using flag would make an API more
>> consistent.
> 
> OK I will respin with user space flag.
> 
> Andre, what about the kernel routing entry struct. You wanted me to get
> rid of  KVM_IRQ_ROUTING_EXTENDED_MSI there too. Will you be able to
> manage a usespace wrong setting if the type is not set?

I am about to see how this all fits together, but I don't expect any
serious problems, at least on the kvmtool side.
Instead of setting a different type I just set the flag and guard that
by the capability: should be not an issue.

Cheers,
Andre.
