From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 8 Dec 2011 09:48:31 +0800
Subject: [PATCH v2] pcmcia: pxa: replace IRQ_GPIO() with gpio_to_irq()
In-Reply-To: <CAN1soZyMxP4qKow+XKk09KAdzdctdzz=aiYbiTqek923xirK0A@mail.gmail.com>
References: <1323083166.6763.3.camel@phoenix>
 <CAN1soZyMxP4qKow+XKk09KAdzdctdzz=aiYbiTqek923xirK0A@mail.gmail.com>
Message-ID: <CAN1soZxEdz5FSkC+xBfESAdWgiCnpWcykTa48Xy4RgM4ixCUQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 5, 2011 at 7:29 PM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
> On Mon, Dec 5, 2011 at 7:06 PM, Axel Lin <axel.lin@gmail.com> wrote:
>> Since commit 6384fd "ARM: pxa: rename IRQ_GPIO to PXA_GPIO_TO_IRQ",
>> I got buid errors due to implicit declaration of function 'IRQ_GPIO'.
>>
>> Use common gpio_to_irq() to replace machine dependant macro IRQ_GPIO().
>>
>> Cc: Marek Vasut <marek.vasut@gmail.com>
>> Cc: Ian Molton <spyro@f2s.com>
>> Cc: Jonathan Cameron <jic23@cam.ac.uk>
>> Cc: Zhuang <haojian.zhuang@marvell.com>
>> Cc: Eric Miao <eric.y.miao@gmail.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Signed-off-by: Axel Lin <axel.lin@gmail.com>
>> ---
>> v2:
>> I just found pxa2xx_trizeps4.c also needs to be converted to gpio_to_irq.
>> Thus include the fix for pxa2xx_trizeps4.c in v2.
>>
>> ?drivers/pcmcia/pxa2xx_e740.c ? ? ?| ? 11 +++++++----
>> ?drivers/pcmcia/pxa2xx_palmld.c ? ?| ? ?2 +-
>> ?drivers/pcmcia/pxa2xx_palmtc.c ? ?| ? ?2 +-
>> ?drivers/pcmcia/pxa2xx_stargate2.c | ? ?6 ++++--
>> ?drivers/pcmcia/pxa2xx_trizeps4.c ?| ? ?5 +++--
>> ?drivers/pcmcia/pxa2xx_vpac270.c ? | ? ?4 ++--
>> ?6 files changed, 18 insertions(+), 12 deletions(-)
>>
> Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>

Applied
