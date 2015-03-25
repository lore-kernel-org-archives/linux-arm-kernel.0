From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 Mar 2015 17:37:48 +0000
Subject: [PATCH] KVM: arm/arm64: fix MMIO handling on userland induced
 accesses
In-Reply-To: <1427212996-16844-1-git-send-email-andre.przywara@arm.com>
References: <1427126309-11223-12-git-send-email-andre.przywara@arm.com>
 <1427212996-16844-1-git-send-email-andre.przywara@arm.com>
Message-ID: <5512F26C.4080105@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/03/15 16:03, Andre Przywara wrote:
> The guest is not the only user of the MMIO handling routines, userland
> can also read and write to those handlers. Since we don't use the
> KVM iobus framework in this case, we have to set the data pointer to
> some actual memory before executing the handler routines.
> This allows to use QEMU as the userland control tool.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
> Hi,
> 
> just embarrassingly realised that I haven't tested the latest version of this
> series with QEMU, so this bug slipped me. Sorry for that! I will merge this
> patch in the next revision of this series (or just send a new version of
> 11/12).

I'll squash it into patch #11 when I merge it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
