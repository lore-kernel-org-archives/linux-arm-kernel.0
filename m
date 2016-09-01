From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 1 Sep 2016 13:15:45 +0200
Subject: [PATCH 0/2] arm{,64}/kvm: excise redundant cache maintenance
In-Reply-To: <20160830180020.GB19315@leverpostej>
References: <1472573156-30414-1-git-send-email-mark.rutland@arm.com>
 <20160830180020.GB19315@leverpostej>
Message-ID: <20160901111545.GC10162@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 07:00:20PM +0100, Mark Rutland wrote:
> On Tue, Aug 30, 2016 at 05:05:54PM +0100, Mark Rutland wrote:
> > As noted in a jailhouse thread a short while ago [1,2], the presence of the
> > virtualization extensions implies that page table walks are coherent, and do
> > not require that updates are cleaned to the PoU.
> > 
> > These patches remove the redundant maintenance and related infrastructure.
> > 
> > As I do not have a suitably configured ARMv7 board, I have not been able to
> > test the patches myself, and any testing would be appreciated.
> 
> Having been lent a TC2 booting in Hyp mode, I've now given this a spin
> with a few VMs, which I left running hackbench to fault in guest memory.
> 
> All of that ran happily.
> 
I've tested this on TC2 and CubieTruck as well, no problems as far as I
can see.

Applied.

Thanks,
-Christoffer
