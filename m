From: Mark.Rutland@arm.com (Mark Rutland)
Date: Thu, 14 Jul 2011 10:40:49 +0100
Subject: Lockup with: "ARM: DMA: steal memory for DMA coherent mappings"
Message-ID: <B393A6715F47FC43935D96EA15105EFF20B16F2641@GEORGE.Emea.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I've noticed a lockup on linux-next (next-20110707) on my Vexpress A9x4, which
seems to happen when X11 takes over the framebuffer. Before this the virtual
console is perfectly happy, afterwards it doesn't respond to ping or sysRq
poking. Sometimes the lockup doesn't occur, but X is unable to update the
display.

I bisected this down to your patch "ARM: DMA: steal memory for DMA coherent
mappings" (84e5e8a1). Reverting it made -next work, and I was able to reproduce
the issue with the patch applied to v3.0-rc7. So far I haven't managed to
identify the underlying issue. Are there any prerequisites I could be missing?

I've been unable to find this patch elsewhere (the mailing list, your public
git trees) - am I looking in the wrong places? Are you still planning on
releasing this patch?

Thanks,
Mark.

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
