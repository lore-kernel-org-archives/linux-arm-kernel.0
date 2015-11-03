From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 3 Nov 2015 15:34:16 +0100
Subject: [PATCH] ARM: add v7 LPAE multi-platform defconfig
In-Reply-To: <1445956507-34026-1-git-send-email-b18965@freescale.com>
References: <1445956507-34026-1-git-send-email-b18965@freescale.com>
Message-ID: <20151103143416.GA926@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2015 at 10:35:07PM +0800, Alison Wang wrote:
> v7 LPAE multi-platform defconfig is based on v7 multi-platform
> defconfig and adds LPAE support.
> 
> This defconfig is verified on LS1021A which enables GIANFAR,
> I2C, WATCHDOG, AUDIO, EDMA and DSPI drivers, etc.
> 
> Signed-off-by: Alison Wang <alison.wang@freescale.com>

I think this would be great if it also had:

CONFIG_ARCH_VIRT=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y

That would allow it to be used for KVM testing both as host and guest.

FWIW, I just tried booting this on my TC2, but I don't get any output
from there.  Is it supposed to work on this platform?  If not, why not?

Thanks,
-Christoffer
