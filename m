From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 18 Apr 2013 10:51:43 +0200
Subject: [RFC] arm64: Early printk support for virtio-mmio console devices.
In-Reply-To: <CAFEAcA-38=zx-s3NaBAu-yvDNRbt=KcTs-3c1QJR3COB3G1n2A@mail.gmail.com>
References: <1366264344-28025-1-git-send-email-pranavkumar@linaro.org>
 <ede8ee08bb2616c2ed642200e3357367@localhost>
 <CAFEAcA-38=zx-s3NaBAu-yvDNRbt=KcTs-3c1QJR3COB3G1n2A@mail.gmail.com>
Message-ID: <b67c5c681ce96942c3cc3bd05b8c80d2@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Apr 2013 09:30:52 +0100, Peter Maydell
<peter.maydell@linaro.org> wrote:
> On 18 April 2013 07:49, Marc Zyngier <maz@misterjones.org> wrote:
>> If you need an early console, why not simply wire the 8250 emulation in
>> kvmtool to be useable from the MMIO bus? I reckon this would solve your
>> problem in a more elegant way...
> 
> The other approach I thought of would be something involving
> defining a hypercall interface for console I/O, in the same
> way that we have hypercalls for "start cpu"/"stop cpu"/etc.
> Is there any mileage in considering that approach, or is it
> a non-starter?

That's always possible, but that becomes architecture dependent, which
means code duplication across architectures. I'd rather use the MMIO
infrastructure, which has some commonalities across the board.

        M.
-- 
Fast, cheap, reliable. Pick two.
