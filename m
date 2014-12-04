From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 4 Dec 2014 10:02:25 +0000
Subject: [PATCH] KVM: arm/arm64: vgic: add init entry to VGIC KVM device
In-Reply-To: <547DFCD6.3000406@linaro.org>
References: <1417541251-20761-1-git-send-email-eric.auger@linaro.org>
 <CAFEAcA9YmAVYAOFbmV53Y3zBdcmK9MGSVR4gaLCjKxbyrZ6Xaw@mail.gmail.com>
 <547DFCD6.3000406@linaro.org>
Message-ID: <CAFEAcA_pSiMXX52xUhNBCwiNdZomspFhr_Y+9+F2yb7P_D26bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 December 2014 at 17:54, Eric Auger <eric.auger@linaro.org> wrote:
> as soon as VFIO signaling is set up (the device IRQ index is linked to
> an eventfd, the physical IRQ VFIO handler is installed and the physical
> IRQ is enabled at interrupt controller level), virtual IRQs are likely
> to be injected. With current QEMU code, we setup this VFIO signaling
> *before* the vgic readiness (either on machine init done or reset
> notifier) and we face that issue of early injection. QEMU related
> patches to follow ...

So can you describe in QEMU terms how the lifecycle of these
things works? How do we ensure that we don't start trying
to inject VFIO IRQs before we've even created the vgic, for
instance?

thanks
-- PMM
