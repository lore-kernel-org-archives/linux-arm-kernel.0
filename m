From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Oct 2013 15:54:03 +0100
Subject: [PATCH 0/7] kvmtool: handle guests of a different endianness
In-Reply-To: <1381502195-8263-1-git-send-email-marc.zyngier@arm.com>
References: <1381502195-8263-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20131011145403.GP14732@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 11, 2013 at 03:36:28PM +0100, Marc Zyngier wrote:
> This patch series adds some infrastructure to kvmtool to allow a BE
> guest to use virtio-mmio on a LE host, provided that the architecture
> actually supports such madness.
> 
> Not all the backend have been converted, only those I actually cared
> about. Converting them is pretty easy though, and will be done if the
> method is deemed acceptable.
> 
> This has been tested on arm64, with some fixes to KVM and a set of
> changes to virtio, both which I am posting separately.
> 
> A branch containing all the relevant changes is at:
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/be-on-le-3.12-rc4

Whilst this looks like the right sort of idea, I think the virtio spec needs
to be updated before we can implement this stuff in kvmtool. Have you warned
Rusty?

Will
