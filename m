From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 19 Jan 2010 17:16:11 +0000
Subject: [RFC 06/18] arm: msm: implement proper dmb() for 7x27
In-Reply-To: <1263250057-26692-7-git-send-email-dwalker@codeaurora.org>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
	<1263250057-26692-7-git-send-email-dwalker@codeaurora.org>
Message-ID: <20100119171611.GB1323@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Walker wrote:
> From: Larry Bassel <lbassel@quicinc.com>
> 
> For 7x27 it is necessary to write to strongly
> ordered memory after executing the coprocessor 15
> instruction dmb instruction.
> 
> This is only for data barrier dmb().
> Note that the test for 7x27 is done on all MSM platforms
> (even ones such as 7201a whose kernel is distinct from
> that of 7x25/7x27).

How is userspace dealing with this?

Userspace also needs dmb(), in threaded code.

See __kernel_dmb in arch/arm/kernel/entry-armv.S.

-- Jamie
