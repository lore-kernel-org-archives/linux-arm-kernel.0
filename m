From: b.brezillon@overkiz.com (boris brezillon)
Date: Thu, 08 Aug 2013 06:10:54 +0200
Subject: [PATCH] pinctrl: at91: choose appropriate handler for level
 interrupts
In-Reply-To: <CACRpkdbte37s-nG-QqmbD=TrVEsSDBFTRX0fjbfUfHpwHSjLDw@mail.gmail.com>
References: <1374331893-16009-1-git-send-email-b.brezillon@overkiz.com>
 <CACRpkdbte37s-nG-QqmbD=TrVEsSDBFTRX0fjbfUfHpwHSjLDw@mail.gmail.com>
Message-ID: <52031A4E.8010605@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2013 20:59, Linus Walleij wrote:
> On Sat, Jul 20, 2013 at 4:51 PM, Boris BREZILLON
> <b.brezillon@overkiz.com> wrote:
>
>> The current implementation handle both edge and level interrupts with the
>> 'handle_simple_irq' handler.
>>
>> Level interrupts are active as long as the pin stays at the configured
>> level (low or high). In this case we have to use 'handle_level_irq' which
>> mask the interrupt until the handle has treated it.
>>
>> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> Patch applied with Alexandre's Tested-by tag.
Thanks
>
> Worst thing that can happen is that I have to revert it.
> Now it will atleast get some testing in linux-next.
>
> Yours,
> Linus Walleij
