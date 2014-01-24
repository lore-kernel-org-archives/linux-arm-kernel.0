From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Jan 2014 15:59:46 +0000
Subject: [PATCH] arm64: Add CONFIG_CC_STACKPROTECTOR
In-Reply-To: <52E16E42.5040000@codeaurora.org>
References: <1390325166-16840-1-git-send-email-lauraa@codeaurora.org>
 <20140122112847.GG1621@mudshark.cambridge.arm.com>
 <52E00AFF.1060701@codeaurora.org>
 <alpine.LFD.2.11.1401231419110.1652@knanqh.ubzr>
 <52E16E42.5040000@codeaurora.org>
Message-ID: <20140124155945.GD31040@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 23, 2014 at 07:32:18PM +0000, Laura Abbott wrote:
> On 1/23/2014 11:23 AM, Nicolas Pitre wrote:
> > Did gcc for Aarch64 replicate the same global variable arrangement?
> > That would be unfortunate...
> >
> 
> Based on my experiments they did unfortunately do so.

Yes, and speaking to the tools guys, it would require an new ABI to fix
this. Given that I don't expect to see any UP AArch64 cores, I'd say drop
the #ifndef SMP part from this patch.

Will
