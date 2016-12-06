From: geoff@infradead.org (Geoff Levand)
Date: Tue, 6 Dec 2016 10:28:19 -0800
Subject: [PATCH] arm64: Add CMDLINE_EXTEND
In-Reply-To: <20161206122040.GH2498@arm.com>
References: <61060b44-64a9-d628-4faf-3a7ae06048aa@infradead.org>
 <20161205120842.GA14429@e104818-lin.cambridge.arm.com>
 <b958f2b6-73fd-e4f5-4fa5-6d2f8330da8f@infradead.org>
 <20161206122040.GH2498@arm.com>
Message-ID: <52e471aa-9ad8-2a6a-efc4-0746b93ab37a@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 12/06/2016 04:20 AM, Will Deacon wrote:
> On Mon, Dec 05, 2016 at 09:41:06AM -0800, Geoff Levand wrote:
>> On 12/05/2016 04:08 AM, Catalin Marinas wrote:
>>> On Fri, Dec 02, 2016 at 02:17:02PM -0800, Geoff Levand wrote:
>>>> The device tree code already supports CMDLINE_EXTEND,
>>>> so add the config option to make it available on arm64.
>>>
>>> What's your use-case for this patch? Note that both CMDLINE_FORCE and
>>> CMDLINE_EXTEND (if we introduce it) are ignored by the EFI stub.
>>> However, we don't seem to have stated this anywhere.
>>
>> I use this in CoreOS, where we need to set "acpi=force" for
>> arm64.  CoreOS uses a proper UEFI + grub.
> 
> So why can't you just set that in grub if you want to boot with ACPI?

That is how I originally did it, but it was suggested I
do it in the kernel config.  See:

  https://github.com/coreos/scripts/pull/610

Is there any reason why we don't want arm64 to have
CMDLINE_EXTEND?

-Geoff
