From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 30 Aug 2016 19:00:20 +0100
Subject: [PATCH 0/2] arm{,64}/kvm: excise redundant cache maintenance
In-Reply-To: <1472573156-30414-1-git-send-email-mark.rutland@arm.com>
References: <1472573156-30414-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160830180020.GB19315@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 05:05:54PM +0100, Mark Rutland wrote:
> As noted in a jailhouse thread a short while ago [1,2], the presence of the
> virtualization extensions implies that page table walks are coherent, and do
> not require that updates are cleaned to the PoU.
> 
> These patches remove the redundant maintenance and related infrastructure.
> 
> As I do not have a suitably configured ARMv7 board, I have not been able to
> test the patches myself, and any testing would be appreciated.

Having been lent a TC2 booting in Hyp mode, I've now given this a spin
with a few VMs, which I left running hackbench to fault in guest memory.

All of that ran happily.

Thanks,
Mark.
