From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Jun 2012 09:55:53 +0100
Subject: [PATCH 0/2] ARM: vexpress: Enable SPARSE_IRQ selection
In-Reply-To: <1339607602-3846-1-git-send-email-tixy@linaro.org>
References: <1339607602-3846-1-git-send-email-tixy@linaro.org>
Message-ID: <20120614085553.GB28714@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 06:13:20PM +0100, Jon Medhurst (Tixy) wrote:
> To enable vexpress to be included in multiplatform kernels containing
> boards which require SPARSE_IRQ, we need to also support this option.
> This turns out to be very simple...
> 
> [PATCH 1/2] ARM: vexpress: Remove IRQ defines from mach/irq.h
> [PATCH 2/2] ARM: vexpress: Enable selection of SPARSE_IRQ

So you're relying on the GIC IRQs starting at 0, and so that the local
timer interrupt stays at 29 ?  And the local timer interrupt is now
just some random number buried in some C file.
