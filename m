From: olof@lixom.net (Olof Johansson)
Date: Mon, 16 Sep 2013 15:28:38 -0700
Subject: [PATCH 1/2] mtd: atmel_nand: remove unneeded ifdef CONFIG_OF
In-Reply-To: <20130913182144.GF4550@ld-irv-0074.broadcom.com>
References: <1378200028-15415-1-git-send-email-josh.wu@atmel.com>
 <20130911230207.GE4550@ld-irv-0074.broadcom.com>
 <5232DAAD.4020700@atmel.com>
 <20130913182144.GF4550@ld-irv-0074.broadcom.com>
Message-ID: <CAOesGMjczRxKhDS9W9SZk4ivuxEsn0Mp6j0Xotz+qZgoKO4=xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

On Fri, Sep 13, 2013 at 11:21 AM, Brian Norris
<computersforpeace@gmail.com> wrote:
> + devicetree at vger.kernel.org
>
> On Fri, Sep 13, 2013 at 05:28:13PM +0800, Josh Wu wrote:
>> On 9/12/2013 7:02 AM, Brian Norris wrote:
>> >On Tue, Sep 03, 2013 at 05:20:27PM +0800, Josh Wu wrote:
>> >>Since following commit
>> >>   f3b391425d21e6138e57b2432d91134e0bc2b975
>
> ...
>
>> >>   (of_mtd: Add no-op stubs to support CONFIG_OF=n)
>> >>
>> >>implements the stub for CONFIG_OF=n. Now we can safely remove all
>> >>CONFIG_OF in atmel_nand. (Thanks to Ezequiel Garcia's for this protype)
>> >I'm not quite so sure about this patch, as I was about the pxa3xx patch.
>> >With pxa3xx, the compiler can easily tell that pxa3xx_nand_probe_dt()
>> >will return 0 without doing anything in the !CONFIG_OF case (and so will
>> >likely remove the dead code), so it's no benefit to have the #ifdef. But
>> >in this driver, the atmel_of_init_port() function can't be trivially
>> >determined to do nothing (and in fact, it does something in either
>> >CONFIG_OF=y or =n case). It's only protected by the 'if
>> >(pdev->dev.of_node)' check, which the compiler can't predict.
>>
>> I understand your concern here.
>>
>> >
>> >So, I don't know if we should remove the #ifdef at the expense of likely
>> >significantly larger code. I won't protest, but I won't merge it yet
>> >either. Perhaps others have better ideas, or perhaps you can find a good
>> >way to work around this -- e.g., check the of_* helpers for -ENOSYS early
>> >in atmel_of_init_port()?


Can we please get less fumbling around on this and just merge a fix,
please? You guys have broken the PXA3xx builds for the whole merge
window, while there's been a patch sitting in linux-next with
_exactly_ this contents since August 30, committed by David.

If this is't fixed within the next few days I'll just pick that patch
up and include it in our next batch of arm-soc fixes. This is
ridiculous.


-Olof
