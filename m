From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Jan 2013 16:00:51 +0000
Subject: [PATCH v5 00/14] KVM/ARM Implementation
In-Reply-To: <20130108183811.46302.58543.stgit@ubuntu>
References: <20130108183811.46302.58543.stgit@ubuntu>
Message-ID: <20130114160051.GH18935@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On Tue, Jan 08, 2013 at 06:38:34PM +0000, Christoffer Dall wrote:
> The following series implements KVM support for ARM processors,
> specifically on the Cortex-A15 platform.

[...]

This is looking pretty good to me now and I feel that the longer it stays
out-of-tree, the more issues will creep in (without continual effort from
yourself and others). I've sent some minor comments (mainly vgic-related)
so, if you fix those, then you can add:

  Reviewed-by: Will Deacon <will.deacon@arm.com>

for the series.

Now, there's a lot of code here and merging isn't completely
straightforward. I propose:

  * The first series should go via Russell's tree. It depends on my
    perf branch for the CPU type stuff, but that should go in for 3.9
    anyway (also via Russell).

  * The vGIC patches need rebasing on top of Rob Herring's work, which
    he sent a pull for over the weekend:

      http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/141488.html

    In light of that, this stuff will need to go via arm-soc.

  * The hyp arch-timers are in a similar situation to the vGIC: Mark Rutland
    is moving those into drivers:

      http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/140560.html

    so the kvm bits will need rebasing appropriately and also sent to
    arm-soc (Mark -- I assume you intend to send a PULL for 3.9 for those
    patches?)

Obviously this is all open for discussion, but that seems like the easiest
option to me.

Cheers,

Will
