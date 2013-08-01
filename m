From: b.brezillon@overkiz.com (boris brezillon)
Date: Thu, 01 Aug 2013 13:07:13 +0200
Subject: [PATCH] pinctrl: at91: choose appropriate handler for level
 interrupts
In-Reply-To: <51FA40AC.8060900@free-electrons.com>
References: <1374331893-16009-1-git-send-email-b.brezillon@overkiz.com>
 <51FA40AC.8060900@free-electrons.com>
Message-ID: <51FA4161.50909@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2013 13:04, Alexandre Belloni wrote:
> Hi,
>
> On 20/07/2013 16:51, Boris BREZILLON wrote:
>> The current implementation handle both edge and level interrupts with the
>> 'handle_simple_irq' handler.
>>
>> Level interrupts are active as long as the pin stays at the configured
>> level (low or high). In this case we have to use 'handle_level_irq' which
>> mask the interrupt until the handle has treated it.
>>
>> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> This solves the issue on my side.
>
> Tested-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>
>
Thanks
