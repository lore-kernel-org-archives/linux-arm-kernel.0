From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 01 Mar 2011 19:02:27 -0500 (EST)
Subject: [PATCH 2/4] msm: scm: Fix improper register assignment
In-Reply-To: <4D6D652A.5050502@codeaurora.org>
References: <1298573085-23217-1-git-send-email-sboyd@codeaurora.org>
	<1298573085-23217-3-git-send-email-sboyd@codeaurora.org>
	<1298640219.958.74.camel@e102144-lin.cambridge.arm.com>
	<4D688AF1.1090607@codeaurora.org>
	<20110226084736.GB3640@n2100.arm.linux.org.uk>
	<8yazkpi3cfa.fsf@huya.qualcomm.com>
	<alpine.LFD.2.00.1102261452340.22034@xanadu.home>
	<1298975837.7828.9.camel@e102144-lin.cambridge.arm.com>
	<4D6D652A.5050502@codeaurora.org>
Message-ID: <alpine.LFD.2.00.1103011858370.6799@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 1 Mar 2011, Saravana Kannan wrote:

> On 03/01/2011 02:37 AM, Will Deacon wrote:
> > Perhaps a more robust fix would be to remove the register int
> > declarations and handle the parameter marshalling in the same asm block
> > that contains the smc?
> 
> I was thinking the same, but the opposing idea I heard was that not doing it
> inside the asm block would allow GCC to be make better use of the registers.

Indeed.  And a significant body of code out there does rely on this gcc 
feature, so it has to minimally work.

> Didn't have a strong opinion either way, so we went with the implementation
> that was sent out.

ACK.


Nicolas
