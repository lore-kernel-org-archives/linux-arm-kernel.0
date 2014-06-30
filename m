From: jonathan@jonmasters.org (Jon Masters)
Date: Mon, 30 Jun 2014 12:19:15 -0400
Subject: [RFC v2] ARM VM System Specification
In-Reply-To: <9801429.iblEns5zC3@wuerfel>
References: <20140328184517.GA27219@cbox> <20140611065412.GA24286@lvm>
 <53981043.3010300@redhat.com> <9801429.iblEns5zC3@wuerfel>
Message-ID: <53B18E03.4050902@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/11/14, 5:06 AM, Arnd Bergmann wrote:
> On Wednesday 11 June 2014 10:16:03 Paolo Bonzini wrote:
>>
>>> If kernels actually do use the UEFI runtime services and have no need
>>> for direct access to an RTC when runing in a UEFI compliant system, then
>>> I agree with not specifying the hardware details.
>>
>> The RTC is not needed for ordinary operation of the kernel and, in the
>> current kernel, the EFI RTC driver is only used for IA64.  However, it
>> seems to be platform independent.  I'll give it a shot (on x86, since
>> that's the only architecture for which I know how to get UEFI firmware).
>
> Using the EFI RTC seems appropriate for ARM, as it's a reasonable
> abstraction that should work with any hypervisor. I suspect the only
> reason we don't use it on x86 is that we know which RTC hardware we
> have and the kernel comes with a mandatory driver already.

(sorry for delay in responding to this thread)

Indeed. We should use the EFI RTC driver in general, rather than push 
for many individual RTC drivers on aarch64 systems that are EFI enabled. 
Within Red Hat, we currently have EFI Runtime Services live in many of 
our labs and are using the EFI RTC. This is the way forward.

Jon.
