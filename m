From: james.morse@arm.com (James Morse)
Date: Thu, 04 May 2017 09:19:23 +0100
Subject: [PATCH v3 1/3] arm64: kvm: support kvmtool to detect RAS extension
 feature
In-Reply-To: <8d443da4-d17f-2487-10d5-b6c9639dc5a4@redhat.com>
References: <1493530677-4919-1-git-send-email-gengdongjiu@huawei.com>
 <20170502075631.GE16940@cbox>
 <8d443da4-d17f-2487-10d5-b6c9639dc5a4@redhat.com>
Message-ID: <590AE40B.7060002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paolo,

On 02/05/17 16:48, Paolo Bonzini wrote:
> On 02/05/2017 09:56, Christoffer Dall wrote:
>> The subject and description of these patches are also misleading.
>> Hopefully this is in no way tied to kvmtool, but to userspace
>> generically, for example also to be used by QEMU?
> 
> Yes, QEMU already has a similar capability on x86.
> 
> Does ARM support background scrubbing of memory to detect errors? 

As part of RAS support, yes. A way for firmware to notify the OS about these
events was recently added to the ACPI specification.
We are aiming to turn on ARCH_SUPPORTS_MEMORY_FAILURE which does the Linux end
of things. Punit has a series here:
https://www.spinics.net/lists/arm-kernel/msg575944.html


> If
> so, are there any plans to support action-optional SIGBUS on ARM?

It looks like ARCH_SUPPORTS_MEMORY_FAILURE will bring that in, so yes.



Thanks,

James
