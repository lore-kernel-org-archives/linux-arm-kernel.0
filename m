From: robherring2@gmail.com (Rob Herring)
Date: Wed, 14 Aug 2013 09:05:04 -0500
Subject: [PATCH 0/2] DMA: AMBA PL08x DMA driver fixes due to
 ARCH_DMA_ADDR_T_64BIT
In-Reply-To: <20130814130018.GR23006@n2100.arm.linux.org.uk>
References: <1376484729-11826-1-git-send-email-andre.przywara@linaro.org>
 <20130814130018.GR23006@n2100.arm.linux.org.uk>
Message-ID: <CAL_Jsq+=axr91_1Qzhku2DLE8MmkyPZtCyHUj0WOG4x+tqWK8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 8:00 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Aug 14, 2013 at 02:52:07PM +0200, Andre Przywara wrote:
>> Rob's recent pull request (Highbank fixes for 3.12) promoted the
>> dma_addr_t to 64bit:
>> commit ac072f427a4266b28a948c67a97a8c46f49b662d
>> Author: Rob Herring <rob.herring@calxeda.com>
>> Date:   Tue Aug 13 15:55:07 2013 -0500
>>
>>     ARM: highbank: select ARCH_DMA_ADDR_T_64BIT for LPAE
>>
>> Unfortunately this breaks the AMBA PL08x driver.
>> Fixes are pretty easy: replacing modulo with AND and fix printk
>> format types.
>
> I thought I effectively said no to that patch, and told Rob to go and look
> at my patch series.

I thought you only objected to doing this unconditionally for all
LPAE, so I made it highbank specific like exynos is.

Rob
