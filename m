From: will.deacon@arm.com (Will Deacon)
Date: Thu, 29 Sep 2011 10:42:43 +0100
Subject: [PATCHv2 2/2] ARM: debug: Move DEBUG_ICEDCC into the DEBUG_LL
	choice
In-Reply-To: <20110929092102.GB25061@e102144-lin.cambridge.arm.com>
References: <1316568208-4518-1-git-send-email-sboyd@codeaurora.org>
	<1316568208-4518-2-git-send-email-sboyd@codeaurora.org>
	<4E83D25C.6020306@codeaurora.org>
	<20110929092102.GB25061@e102144-lin.cambridge.arm.com>
Message-ID: <20110929094243.GC25061@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2011 at 10:21:02AM +0100, Will Deacon wrote:
> On Thu, Sep 29, 2011 at 03:05:16AM +0100, Stephen Boyd wrote:
> > Chatting with David Brown made me realize that this patch now forces
> > ICEDCC for anybody who selects DEBUG_LL and hasn't moved to adding a
> > Kconfig in the choice menu. I'm not sure if that actually matters since
> > it may be incentive to put your machine of choice into this menu.
> > 
> > Otherwise, we may want to drop this until a later point, or just leave
> > it out of the choice menu altogether.
> 
> Given that the ICEDCC stuff shouldn't cause any other problems by having it
> enabled (that is, your kernel should still boot) then we should be alright
> leaving this as-is while platforms move over to the new scheme.

Bah, just took this for a spin on my Realview-PBX (Cortex-A9) platform and
the board won't boot unless I have a hardware debugger enabled that can
service the comms channel. This contradicts the Kconfig text which says:

	  It does include a timeout to ensure that the system does not
	  totally freeze when there is nothing connected to read.

so we certainly need to fix something!

Will
