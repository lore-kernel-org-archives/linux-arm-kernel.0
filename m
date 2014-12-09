From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 9 Dec 2014 13:38:37 +0100
Subject: [GIT PULL 2/9] arm/arm64: kvm: drop inappropriate use of
 kvm_is_mmio_pfn()
In-Reply-To: <20141209123814.GA15880@cbox>
References: <1418124368-28418-1-git-send-email-christoffer.dall@linaro.org>
 <1418124368-28418-3-git-send-email-christoffer.dall@linaro.org>
 <CAKv+Gu8Y+gQmDBGCwiLYGpTtE9MnNpu6YnNJDEJjBoi+XBxV2g@mail.gmail.com>
 <20141209123814.GA15880@cbox>
Message-ID: <CAKv+Gu-fjto6xZjGUm6K4qQy=1sezGSq9LdYK1-LOzRawsJSFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 December 2014 at 13:38, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Tue, Dec 09, 2014 at 01:29:52PM +0100, Ard Biesheuvel wrote:
>> On 9 December 2014 at 12:26, Christoffer Dall
>> <christoffer.dall@linaro.org> wrote:
>> > From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> >
>> > Instead of using kvm_is_mmio_pfn() to decide whether a host region
>> > should be stage 2 mapped with device attributes, add a new static
>> > function kvm_is_device_pfn() that disregards RAM pages with the
>> > reserved bit set, as those should usually not be mapped as device
>> > memory.
>> >
>> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>
>> As I mentioned last week, this patch (and the next one) are already in
>> 3.18 so unless there is some policy I am unaware of, these do not have
>> to be submitted again.
>>
> They're in kvmarm/next, which is a stable branch (doesn't rebase) so our
> only choice would be to revert this commit specifically in kvmarm/next
> before sending the pull request.  Since that would be more confusing
> than help anything, and Paolo said to just include the duplicate commit
> in the pull request, here it is.
>
> As we can see in linux-next, it's not really a problem.
>

OK, thanks for the explanation.

-- 
Ard.
