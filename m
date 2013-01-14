From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 14 Jan 2013 17:31:58 -0500
Subject: [PATCH v5 00/14] KVM/ARM Implementation
In-Reply-To: <20130114160051.GH18935@mudshark.cambridge.arm.com>
References: <20130108183811.46302.58543.stgit@ubuntu>
 <20130114160051.GH18935@mudshark.cambridge.arm.com>
Message-ID: <CANM98qL9SZHtQSij5K1z7FADF224fkwBfPmXypgoooLD0htO9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 11:00 AM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Christoffer,
>
> On Tue, Jan 08, 2013 at 06:38:34PM +0000, Christoffer Dall wrote:
>> The following series implements KVM support for ARM processors,
>> specifically on the Cortex-A15 platform.
>
> [...]
>
> This is looking pretty good to me now and I feel that the longer it stays
> out-of-tree, the more issues will creep in (without continual effort from
> yourself and others). I've sent some minor comments (mainly vgic-related)
> so, if you fix those, then you can add:
>
>   Reviewed-by: Will Deacon <will.deacon@arm.com>
>
> for the series.

A big thanks!

>
> Now, there's a lot of code here and merging isn't completely
> straightforward. I propose:
>
>   * The first series should go via Russell's tree. It depends on my
>     perf branch for the CPU type stuff, but that should go in for 3.9
>     anyway (also via Russell).
>

Great.

>   * The vGIC patches need rebasing on top of Rob Herring's work, which
>     he sent a pull for over the weekend:
>
>       http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/141488.html
>
>     In light of that, this stuff will need to go via arm-soc.
>
>   * The hyp arch-timers are in a similar situation to the vGIC: Mark Rutland
>     is moving those into drivers:
>
>       http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/140560.html
>
>     so the kvm bits will need rebasing appropriately and also sent to
>     arm-soc (Mark -- I assume you intend to send a PULL for 3.9 for those
>     patches?)
>
> Obviously this is all open for discussion, but that seems like the easiest
> option to me.
>
Makes good sense. Given that there are no other major disputes over
the code we are a couple of people strongly hoping that this can
happen for 3.9.

In any case, I'll do whatever makes the process the easiest for you guys.

Best,
-Christoffer
