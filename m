From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 27 Aug 2013 09:46:10 +0200
Subject: [PATCH] tegra-cpuidle: provide stub when !CONFIG_CPU_IDLE
In-Reply-To: <521BD48F.1060202@wwwdotorg.org>
References: <20130826153050.GC8764@redacted.bos.redhat.com>
 <521BD48F.1060202@wwwdotorg.org>
Message-ID: <20130827074609.GE8686@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 26, 2013 at 04:19:59PM -0600, Stephen Warren wrote:
> On 08/26/2013 09:30 AM, Kyle McMartin wrote:
> > While poking at something using the for-3.12/* trees, I hit the
> > following compile error:
> > drivers/built-in.o: In function `tegra_pcie_map_irq':
> > /builddir/build/BUILD/kernel-3.10.fc20/linux-3.11.0-0.rc6.git4.1.fc20.armv7hl/drivers/pci/host/pci-tegra.c:640:
> > undefined reference to `tegra_cpuidle_pcie_irqs_in_use'
> > drivers/built-in.o: In function `tegra_msi_map':
> > /builddir/build/BUILD/kernel-3.10.fc20/linux-3.11.0-0.rc6.git4.1.fc20.armv7hl/drivers/pci/host/pci-tegra.c:1227:
> > undefined reference to `tegra_cpuidle_pcie_irqs_in_use'
> > make: *** [vmlinux] Error 1
> > 
> > Since our .config had CONFIG_CPU_IDLE off. We should probably provide
> > an empty function to handle this to avoid cluttering up pci-tegra.c
> > with conditionals.
> 
> Another approach would be to use if (IS_ENABLED(CPU_IDLE)) at the call
> site. I guess the approach in this patch is better than that though,
> since it doesn't pollute the callers with knowledge of when this
> function is available.
> 
> Thierry, if you're OK with this, I can forward it on to arm-soc.

I agree. The dummy seems like the better option. Feel free to add my
Reviewed-by (in my reply to the original patch) when you forward.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130827/464ff10d/attachment.sig>
