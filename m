From: eric@anholt.net (Eric Anholt)
Date: Fri, 08 Apr 2016 11:20:30 -0700
Subject: [PATCH 4/4] irqchip: bcm2836: Use a more generic memory barrier
 call
In-Reply-To: <570497C7.10501@wwwdotorg.org>
References: <1459827858-3871-1-git-send-email-eric@anholt.net>
 <1459827858-3871-5-git-send-email-eric@anholt.net>
 <570497C7.10501@wwwdotorg.org>
Message-ID: <87a8l40xox.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 04/04/2016 09:44 PM, Eric Anholt wrote:
>> dsb() requires an argument on arm64, so we needed to add "sy".
>> Instead, take this opportunity to switch to the same smp_wmb() call
>> that gic uses for its IPIs.  This is a less strong barrier than we
>> were doing before (dmb(ishst) compared to dsb(sy)), but it seems to be
>> the correct one.
>
> I assume all MMIO is part of the ish domain?
>
> If so, the series,
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>

I don't know if this barrier implies ordering all the way out to AXI on
this HW, but I don't think that's a requirement of this function.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160408/bd4f2397/attachment.sig>
