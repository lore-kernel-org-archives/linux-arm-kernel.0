From: panand@redhat.com (Pratyush Anand)
Date: Fri, 2 Jun 2017 20:12:57 +0530
Subject: [PATCH v3 0/2] kexec-tools: arm64: Enable D-cache in purgatory
In-Reply-To: <59312080.1090906@arm.com>
References: <cover.1495514291.git.panand@redhat.com> <59312080.1090906@arm.com>
Message-ID: <1963984d-e78e-a5b2-f1a2-fb0a789a505e@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On Friday 02 June 2017 01:53 PM, James Morse wrote:
> Hi Pratyush,
>
> On 23/05/17 06:02, Pratyush Anand wrote:
>> It takes more that 2 minutes to verify SHA in purgatory when vmlinuz image
>> is around 13MB and initramfs is around 30MB. It takes more than 20 second
>> even when we have -O2 optimization enabled. However, if dcache is enabled
>> during purgatory execution then, it takes just a second in SHA
>> verification.
>>
>> Therefore, these patches adds support for dcache enabling facility during
>> purgatory execution.
>
> I'm still not convinced we need this. Moving the SHA verification to happen
> before the dcache+mmu are disabled would also solve the delay problem,

Humm..I am not sure, if we can do that.

When we leave kernel (and enter into purgatory), icache+dcache+mmu are already 
disabled. I think, that would be possible when we will be in a position to use 
in-kernel purgatory.

> and we
> can print an error message or fail the syscall.
>
> For kexec we don't expect memory corruption, what are we testing for?
> I can see the use for kdump, but the kdump-kernel is unmapped so the kernel
> can't accidentally write over it.
>
> (we discussed all this last time, but it fizzled-out. If you and the
>  kexec-tools maintainer think its necessary, fine by me!)

Yes, there had already been discussion and MAINTAINERs have discouraged 
none-purgatory implementation.

>
> I have some comments on making this code easier to maintain..
>

Thanks.

I have implemented your review comments and have archived the code in

https://github.com/pratyushanand/kexec-tools.git : purgatory-enable-dcache

I will be posting the next version only when someone complains about ARM64 
kdump behavior that it is not as fast as x86.

Thanks for all your time on this series. That really helped me to understand 
the arm64 page table in a better way.

~Pratyush
