From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Aug 2013 14:00:19 +0100
Subject: [PATCH 0/2] DMA: AMBA PL08x DMA driver fixes due to
 ARCH_DMA_ADDR_T_64BIT
In-Reply-To: <1376484729-11826-1-git-send-email-andre.przywara@linaro.org>
References: <1376484729-11826-1-git-send-email-andre.przywara@linaro.org>
Message-ID: <20130814130018.GR23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 02:52:07PM +0200, Andre Przywara wrote:
> Rob's recent pull request (Highbank fixes for 3.12) promoted the
> dma_addr_t to 64bit:
> commit ac072f427a4266b28a948c67a97a8c46f49b662d
> Author: Rob Herring <rob.herring@calxeda.com>
> Date:   Tue Aug 13 15:55:07 2013 -0500
> 
>     ARM: highbank: select ARCH_DMA_ADDR_T_64BIT for LPAE
>     
> Unfortunately this breaks the AMBA PL08x driver.
> Fixes are pretty easy: replacing modulo with AND and fix printk
> format types.

I thought I effectively said no to that patch, and told Rob to go and look
at my patch series.

Your patch series is wrong to fix this.  We're just piling more bad fixes
on top of a bug in the generic parts of the kernel.  Please stop this
madness.
