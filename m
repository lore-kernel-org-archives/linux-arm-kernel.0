From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Dec 2017 13:59:31 +0100
Subject: [PATCH v5 0/4] ARM: ep93xx: ts72xx: Add support for BK3 board
In-Reply-To: <CACRpkda8xPuVHpBvX6_Ez+ztn4neVZ+=x=AEWmHJyZgww-1jHg@mail.gmail.com>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171211233625.5689-1-lukma@denx.de>
 <CACRpkdbCeBCENDcRcYBKTXVNz6H3t=WKHYP8Uf3WJ=Wvtib1Jg@mail.gmail.com>
 <1513153607.2439.2.camel@Nokia-N900>
 <CAK8P3a2jEVQXKXJXp27ft5oaD8Jbo6g1fB-t_aduJWhC2dtJ0g@mail.gmail.com>
 <20171217204122.0a10a5e1@jawa>
 <CAK8P3a09V1ZhhVCvdy27BiBCMM54zo4qyypgSDvrg2CdpneVmg@mail.gmail.com>
 <20171217222856.2c5937a4@jawa>
 <CAK8P3a3VJapioU32oBtA2GDmvXiHvz3K=W6BGx+u=Tvb1aDXsg@mail.gmail.com>
 <CACRpkda8xPuVHpBvX6_Ez+ztn4neVZ+=x=AEWmHJyZgww-1jHg@mail.gmail.com>
Message-ID: <CAK8P3a3nj_WwCVZOGZr3v_p8BpnDRkKfjgDSZ3yVx6knU1rHvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 1:48 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Dec 18, 2017 at 12:55 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Sun, Dec 17, 2017 at 10:28 PM, Lukasz Majewski <lukma@denx.de> wrote:
>>>> It would also be helpful
>>>> to test whether the -march=armv4t/--fix-v4bx workaround produces
>>>> working binaries for you, in that case you could report to the gcc
>>>> developers that the removal of armv4 can continue but that
>>>> the --fix-v4bx option in ld needs to stay around.
>>>
>>> I may ask this issue on OE/Yocto mailing list as well....
>>
>> To clarify, the only  affected platforms are those based on either
>> DEC/Intel StrongARM or Faraday FA526, i.e. EBSA-110,
>> FootBridge, RPC, SA1100, Moxart and Gemini.
>
> It's a bit unfortunate since there are users and active contributors to
> these architectures, I think the OE community is being missed out
> just because they "are not Debian". :/

IIRC, OE already uses the --fix-v4bx workaround. I had an older patch
to do the same in the kernel, let me resend it now, so you can try it
and see if that works for you.

       Arnd
