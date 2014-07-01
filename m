From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 1 Jul 2014 11:50:56 +0100
Subject: [RFC 1/4] ARM: tegra: Move SoC drivers to drivers/soc/tegra
In-Reply-To: <20140630193635.GB32594@mithrandir>
References: <1403888329-24755-1-git-send-email-thierry.reding@gmail.com>
 <53AEF81D.3080408@ti.com> <20140628204025.GA16415@ulmo>
 <7497427.LQy8pJts8f@wuerfel> <20140630090118.GA24128@ulmo>
 <20140630103649.GF28951@arm.com> <20140630104814.GA1495@ulmo>
 <20140630131628.GA31517@e102568-lin.cambridge.arm.com>
 <20140630193635.GB32594@mithrandir>
Message-ID: <20140701105056.GO18313@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 08:36:36PM +0100, Thierry Reding wrote:
> On Mon, Jun 30, 2014 at 02:16:34PM +0100, Lorenzo Pieralisi wrote:
> > And I think that most of the early bring up issues are just related to
> > powering-up/resetting a cpu for it to be booted, probably that's the
> > abstraction we should be focusing on, because it should just require poking
> > a bunch of registers to kickstart a CPU, no more than that, FW should be
> > able to deal with that and that's yet another reason behind PSCI design.
> 
> Right, I agree that if we can push that into PSCI that would be great
> (provided there's an open-source implementation of PSCI).

At least one (BSD-style license):

https://github.com/ARM-software/arm-trusted-firmware

There are also some patches for U-Boot (only covering secondary CPU
booting for now and not merged yet).

-- 
Catalin
