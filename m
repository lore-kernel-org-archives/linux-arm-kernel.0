From: olof@lixom.net (Olof Johansson)
Date: Mon, 21 Nov 2016 08:19:47 -0800
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Updates for v4.10
In-Reply-To: <CAMuHMdXAuDcbr84phfPRpqZYRzAZf2j4vsv+i_Frz0G8ksd_Vg@mail.gmail.com>
References: <cover.1479387356.git.horms+renesas@verge.net.au>
 <20161119012836.GA2543@localhost>
 <CAMuHMdXAuDcbr84phfPRpqZYRzAZf2j4vsv+i_Frz0G8ksd_Vg@mail.gmail.com>
Message-ID: <CAOesGMjk=KWifGT7sugpWVjNJSKhmgxg8gN9Cgi=emGrg66z0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 1:31 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Olof,
>
> On Sat, Nov 19, 2016 at 2:28 AM, Olof Johansson <olof@lixom.net> wrote:
>> On Thu, Nov 17, 2016 at 02:34:25PM +0100, Simon Horman wrote:
>>> Please consider these second round of Renesas ARM based SoC updates for v4.10.
>
>>> * Basic support for r8a7745 SoC
>>>
>>> ----------------------------------------------------------------
>>> Sergei Shtylyov (2):
>>>       ARM: shmobile: r8a7745: basic SoC support
>>>       ARM: shmobile: document SK-RZG1E board
>>
>> Hi,
>>
>> Is there a reason you're adding a config option per SoC?
>>
>> I think you'd be better off not adding these config options, and just adding
>> support for the SoCs through compatibles (and adding the drivers to defconfigs,
>> etc).
>
> Yes there is a reason: kernel size.
> The main offenders are the pinctrl tables, which add ca. 20-50 KiB per
> supported SoC.

So don't turn on that pinctrl driver unless you have that SoC?

> Note that RZ/A1 (r7s72100) is used on some boards with its internal RAM
> (10 MiB) only.


-Olof
