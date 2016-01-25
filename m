From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Jan 2016 17:15:47 +0100
Subject: [PATCH v2 00/21] arm64: Virtualization Host Extension support
In-Reply-To: <1453737235-16522-1-git-send-email-marc.zyngier@arm.com>
References: <1453737235-16522-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <2703557.vyWRuMlGU2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 January 2016 15:53:34 Marc Zyngier wrote:
> host and guest, reducing the overhead of virtualization.
> 
> In order to have the same kernel binary running on all versions of the
> architecture, this series makes heavy use of runtime code patching.
> 
> The first 20 patches massage the KVM code to deal with VHE and enable
> Linux to run at EL2. The last patch catches an ugly case when VHE
> capable CPUs are paired with some of their less capable siblings. This
> should never happen, but hey...
> 
> I have deliberately left out some of the more "advanced"
> optimizations, as they are likely to distract the reviewer from the
> core infrastructure, which is what I care about at the moment.

One question: as you mention that you use a lot of runtime code patching
to make this work transparently, how does this compare to runtime patching
the existing kernel to run in EL2 mode without VHE? Is that even possible?

My interpretation so far as always been "that's too complicated to
do because it would require a lot of runtime patching", but now we seem
to get that anyway because we want to run a hypervisor-enabled kernel in
either EL1 or EL2 depending on the presence of another feature.

	Arnd
