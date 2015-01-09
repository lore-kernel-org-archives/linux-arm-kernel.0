From: oleg@redhat.com (Oleg Nesterov)
Date: Fri, 9 Jan 2015 18:45:24 +0100
Subject: [RFC 8/8] ARM64: Add uprobe support
In-Reply-To: <54AEC470.50509@redhat.com>
References: <cover.1420038188.git.panand@redhat.com>
 <0694af6935f9c6873ef8d25ad51630a40a74a116.1420038188.git.panand@redhat.com>
 <20150108170324.GT11583@arm.com> <54AEC470.50509@redhat.com>
Message-ID: <20150109174524.GA13161@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08, Pratyush Anand wrote:
>
> On Thursday 08 January 2015 10:33 PM, Will Deacon wrote:
>>
>> I'm assuming that means you don't support compat (AArch32) tasks with this?
>
> Hummm.. Yes, compat not yet supported.
>
> I will come back on this.

I obviously do not know how difficult is to support the compat tasks, and
in any case I leave this to you and Will.

But if this is not simple, perhaps the initial implementation could simply
nack the probe in arch_uprobe_analyze_insn() if this mm is not 64-bit.
Although I do not see something like is_64bit_mm() in arch/arm64... So may be
the first version can even ignore this problem and just document the fact
that AArch32 tasks are not supported.

Oleg.
