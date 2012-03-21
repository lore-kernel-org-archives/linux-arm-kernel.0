From: robherring2@gmail.com (Rob Herring)
Date: Wed, 21 Mar 2012 15:13:49 -0500
Subject: [PATCH 1/2] ARM: dma-mapping: convert
 ARCH_HAS_DMA_SET_COHERENT_MASK to kconfig symbol
In-Reply-To: <CAN1soZwXh6DviO5CHcj_ogM1VK23V2c4CKZf+iMmeP43rwtW9w@mail.gmail.com>
References: <4F68CD9C.3090001@windriver.com>
 <1332296149-28110-1-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1203202230230.24151@xanadu.home>
 <CAN1soZwXh6DviO5CHcj_ogM1VK23V2c4CKZf+iMmeP43rwtW9w@mail.gmail.com>
Message-ID: <4F6A367D.9090102@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2012 03:15 AM, Haojian Zhuang wrote:
> On Wed, Mar 21, 2012 at 10:30 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> On Tue, 20 Mar 2012, Rob Herring wrote:
>>
>>> From: Rob Herring <rob.herring@calxeda.com>
>>>
>>> The only users of ARCH_HAS_DMA_SET_COHERENT_MASK are 2 ARM platforms:
>>> ixp4xx and pxa cm_x2xx. We've been getting lucky that the define is
>>> implicitly included before dma-mapping.h, but the removal of io.h broke
>>> things (c334bc1 ARM: make mach/io.h include optional). Since memory.h
>>> is the correct place, but no longer exists, convert the define to a
>>> kconfig entry.
>>>
>>> Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>>> Cc: Russell King <linux@arm.linux.org.uk>
>>> Cc: Imre Kaloz <kaloz@openwrt.org>
>>> Cc: Krzysztof Halasa <khc@pm.waw.pl>
>>> Cc: Eric Miao <eric.y.miao@gmail.com>
>>> Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
>>> Cc: Vinod Koul <vinod.koul@intel.com>
>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>
>> Acked-by: Nicolas Pitre <nico@linaro.org>
>>
> Acked.
> 
> Imre & Krzysztof,
> 
> Do you mind that I merge these patches into arch-pxa git tree? Since a
> lot of files in arch-pxa are changed.
> 

I plan to send these 2 along with another fix to arm-soc if that's okay.

Rob
