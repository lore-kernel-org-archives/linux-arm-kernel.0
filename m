From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 30 Nov 2015 11:50:03 +0100
Subject: [PATCH] arm: renesas: select PINCTRL for Renesas SoC
In-Reply-To: <565C2635.3090907@codethink.co.uk>
References: <1448648871-15008-1-git-send-email-ben.dooks@codethink.co.uk>
 <CAMuHMdVNDWSehXpuBANFCN4HWx7H6ms9o-Ru-nZ7u9QJiUSNbw@mail.gmail.com>
 <565C2635.3090907@codethink.co.uk>
Message-ID: <CAMuHMdVEqbvNhVTbNbwbfXFVu4AyhkdV7RGiVJhfG9XydVN+3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On Mon, Nov 30, 2015 at 11:34 AM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> On 28/11/15 09:15, Geert Uytterhoeven wrote:
>> On Fri, Nov 27, 2015 at 7:27 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>> If Renesas SoCs are the only devices selected then the
>>> pinctrl core is not selected and the renesas pfc controller
>>> will not get included in the kernel.
>>>
>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>> ---
>>>  arch/arm64/Kconfig.platforms | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>>> index 25a9031..fc3d692 100644
>>> --- a/arch/arm64/Kconfig.platforms
>>> +++ b/arch/arm64/Kconfig.platforms
>>> @@ -72,6 +72,7 @@ config ARCH_SHMOBILE
>>>  config ARCH_RENESAS
>>>         bool "Renesas SoC Platform"
>>>         select ARCH_SHMOBILE
>>> +       select PINCTRL
>>
>> This was added quite a while ago. renesas-devel-20151123-v4.4-rc2 has it.
>
> Hi, where is the tree?

As usual, Simon's Renesas tree:
git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git

Which tree are you looking at?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
