From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 5 Jul 2016 15:52:49 +0100
Subject: [PATCH v2] arm64: defconfig: add options for virtualization and
 containers
In-Reply-To: <CAAqcGHmMtSpaB37HYFwpVg51R+DGdDc2T1fogBSxdW7W0A95EA@mail.gmail.com>
References: <1465979279-23449-1-git-send-email-riku.voipio@linaro.org>
 <20160627111113.GF26498@cbox>
 <CAAqcGHmMtSpaB37HYFwpVg51R+DGdDc2T1fogBSxdW7W0A95EA@mail.gmail.com>
Message-ID: <20160705145248.GJ3565@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2016 at 04:17:00PM +0300, Riku Voipio wrote:
> On 27 June 2016 at 14:11, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> > On Wed, Jun 15, 2016 at 11:27:59AM +0300, Riku Voipio wrote:
> >> Enable options commonly needed by popular virtualization
> >> and container applications. Use modules when possible to
> >> avoid too much overhead for users not interested.
> >>
> >> - add namespace and cgroup options needed
> >> - add seccomp - optional, but enhances Qemu etc
> >> - bridge, nat, veth, macvtap and multicast for routing
> >>   guests and containers
> >> - btfrs and overlayfs modules for container COW backends
> >> - while near it, make fuse a module instead of built-in.
> >>
> >> Generated with make saveconfig and dropping unrelated spurious
> >> change hunks while commiting. bloat-o-meter old-vmlinux vmlinux:
> >>
> >> add/remove: 905/390 grow/shrink: 767/229 up/down: 183513/-94861 (88652)
> >> ....
> >> Total: Before=10515408, After=10604060, chg +0.84%
> >>
> >> Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
> >
> > I'm unclear what the conclusion on the v1 regarding using modules in
> > defconfig was exactly, but I'm happy to see a defconfig that makes it
> > easier to test virtualization.
> 
> I think it was generally agreed that adding modules to defconfig is ok. However
> this patch seems to be a bit stuck in limbo. Anyone going to pick it up?

I can pick it up but usually after -rc1 or close to the end of the
merging window, just to enable some other features that go in.

-- 
Catalin
