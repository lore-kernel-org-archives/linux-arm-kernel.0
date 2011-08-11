From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 11 Aug 2011 09:36:38 +0300
Subject: [PATCH v2] gpio: pl061: add DT binding support
In-Reply-To: <1313011906-24161-1-git-send-email-robherring2@gmail.com>
References: <1312397661-3328-1-git-send-email-robherring2@gmail.com>
	<1313011906-24161-1-git-send-email-robherring2@gmail.com>
Message-ID: <20110811063637.GA3220@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Wed, Aug 10, 2011 at 04:31:46PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This adds devicetree binding support to the ARM pl061 driver removing the
> platform_data dependency. When DT binding is used, the gpio numbering is
> assigned dynamically. For now, interrupts are not supported with DT until
> irqdomains learn dynamic irq assignment.
> 
> Rather than add another case of -1, updating the driver to use NO_IRQ.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
> v2:
> - Add other -1 to NO_IRQ conversions

Migrating existing pl061_platform_data users to NO_IRQ would be nice as well.  
But this should probably be a separate patch.

FWIW:

Acked-by: Baruch Siach <baruch@tkos.co.il>

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
