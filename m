From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 30 Oct 2013 08:28:22 +0000
Subject: [PATCH v2] arm/arm64: KVM: MMIO support for BE guest
In-Reply-To: <CAAhSdy3SUiF8k-WokdsBEM5WLx2ifzDL__ta_sLrHge3Lp34JA@mail.gmail.com>
References: <1383072593-28916-1-git-send-email-marc.zyngier@arm.com>
 <CAAhSdy3SUiF8k-WokdsBEM5WLx2ifzDL__ta_sLrHge3Lp34JA@mail.gmail.com>
Message-ID: <b7620ddbce4278713635321bd9a708f4@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-10-30 01:10, Anup Patel wrote:
> On Wed, Oct 30, 2013 at 12:19 AM, Marc Zyngier <marc.zyngier@arm.com> 
> wrote:
>> Do the necessary byteswap when host and guest have different
>> views of the universe. Actually, the only case we need to take
>> care of is when the guest is BE. All the other cases are naturally
>> handled.
>
> You might want to handle the case where we have LE guest on BE host
> because for ARM64 kernel we might have lot of people interested in
> running host kernel in BE mode with KVM enabled.

What makes you think it is not handled already?

         M.
-- 
Fast, cheap, reliable. Pick two.
