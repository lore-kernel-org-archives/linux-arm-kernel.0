From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Jan 2013 12:03:50 +0000
Subject: [PATCH] ARM: call disable_nonboot_cpus() from machine_shutdown()
In-Reply-To: <1357160861-26282-1-git-send-email-swarren@wwwdotorg.org>
References: <1357160861-26282-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130103120349.GC5193@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 02, 2013 at 09:07:41PM +0000, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> On Tegra at least, this change allows kexec to work with SMP enabled.
> Without this,  machine_shutdown() simply puts all CPUs into a loop. If
> the code of that loop is over-written, the CPUs may hang or crash (which
> I do observe in practice), or cause the kexec'd kernel not to be able to
> initialize them.
> 
> This fix has the added benefit that the kexec always happens on the boot
> CPU, and thus kexec mirrors the initial kernel boot as much as possible.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Will Deacon <will.deacon@arm.com>

Cheers Stephen,

Will
