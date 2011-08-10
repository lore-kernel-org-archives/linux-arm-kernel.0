From: alan@linux.intel.com (Alan Cox)
Date: Wed, 10 Aug 2011 12:55:31 +0100
Subject: [PATCH 1/2] serial: samsung: Add unified interrupt handler for
	s3c64xx and later SoC's
In-Reply-To: <1312971680-3898-2-git-send-email-thomas.abraham@linaro.org>
References: <1312971680-3898-1-git-send-email-thomas.abraham@linaro.org>
	<1312971680-3898-2-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20110810125531.38226d7a@bob.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Aug 2011 15:51:19 +0530
Thomas Abraham <thomas.abraham@linaro.org> wrote:

> s3c64xx and later SoC's include the interrupt mask and pending
> registers in the uart controller, unlike the s3c24xx SoC's which have
> these registers in the interrupt controller. When the mask and
> pending registers are part of the uart controller, a unified
> interrupt handler can handle the tx/rx interrupt. With this, the
> static reservation of interrupt numbers for the uart tx/rx/err
> interrupts in the linux irq space is not required and simplifies
> adding device tree support.

Really only hardware changes so for the tty touching aspect of it

Acked-by: Alan Cox <alan@linux.intel.com>
