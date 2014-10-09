From: will.deacon@arm.com (Will Deacon)
Date: Thu, 9 Oct 2014 10:22:09 +0100
Subject: [PATCH 0/7] arm64 kexec kernel patches V3
In-Reply-To: <cover.1411604443.git.geoff@infradead.org>
Message-ID: <20141009092209.GA3141@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 01:23:26AM +0100, Geoff Levand wrote:
> Hi All,

Hi Geoff,

> This series adds the core support for kexec re-boots on arm64.  I have tested
> with the ARM VE fast model using various kernel config options for both the
> first and second stage kernels.
> 
> To load a second stage kernel and execute a kexec re-boot on arm64 my patches to
> kexec-tools [2], which have not yet been merged upstream, are needed.
> 
> This series does not include some re-work of the spin-table CPU enable method
> that is needed to support it, nor does it include some re-work of KVM to support
> CPU soft reset.  A kernel built with these patches will boot and run correctly,
> but will fail to load a kexec kernel if running on a machine with any spin-table
> enabled CPUs and will fail the kexec re-boot if the first stage kernel was built
> with CONFIG_KVM=y.  Work-in-progress patches to support these are in the master
> branch of my linux-kexec repository [1].

I've been following this thread on the periphery and I think Vivek makes
some good points wrt ABI and purgatory. I'd like to see his Ack on the
series before we merge it.

However, I don't think we need to wait for a spin-table implementation of
CPU hotplug -- that can be done as a seperate, independent series by
somebody fooli^H^H^H^H^Hbrave enough to try it.

Will
