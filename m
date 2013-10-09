From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 09 Oct 2013 07:40:29 +0100
Subject: [PATCH] ARM: KVM: drop arbitrary limitation to 4 CPU VMs
In-Reply-To: <CAFEAcA8vgfyEDhYDYDZc16pgdtFOYe-djWcbB0qh6Hrv7X=-PA@mail.gmail.com>
References: <1381252628-17840-1-git-send-email-marc.zyngier@arm.com>
 <CAFEAcA8vgfyEDhYDYDZc16pgdtFOYe-djWcbB0qh6Hrv7X=-PA@mail.gmail.com>
Message-ID: <468864b7e5c2a2b55664713185844b08@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-10-09 03:15, Peter Maydell wrote:
> On 9 October 2013 02:17, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> It appears we have an arbitrary limitation where we refuse to
>> create more than 4 virtual A15 in a single VM.
>>
>> This limitation doesn't make much sense (the number 4 probably
>> comes from the maximum number of CPUs in a A15 cluster, but
>> KVM doesn't have any notion of cluster)
>
> "Don't allow configurations that can't exist in hardware" makes
> sense as a restriction to me... QEMU will also enforce the 4-cpu
> limit.

Nothing prevents anyone from building a multi-cluster A15 system:
http://www.lsi.com/products/mobile-communication-processors/pages/axxia-communication-processor-axm5500.aspx

If you want to limit QEMU to specific configurations, that's perfectly 
fine. The kernel doesn't need to, and kvmtool won't.

         M.
-- 
Fast, cheap, reliable. Pick two.
