From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 21 Feb 2017 17:36:38 +0100
Subject: [PATCH/RFC 4/6] drivers: firmware: psci: Fix non-PMIC wake-up if
 SYSTEM_SUSPEND cuts power
In-Reply-To: <20170221110730.GF5021@amd>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <1487622809-25127-5-git-send-email-geert+renesas@glider.be>
 <20170221110730.GF5021@amd>
Message-ID: <CAMuHMdX24ONBOovb26epZpKJV1w64NbEhr_Rex=NDPe4e0frmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On Tue, Feb 21, 2017 at 12:07 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Mon 2017-02-20 21:33:27, Geert Uytterhoeven wrote:
>> Nothing in the PSCI specification requires the SoC to remain powered and
>> to support wake-up sources when suspended using SYSTEM_SUSPEND.
>> If the firmware implements the PSCI SYSTEM_SUSPEND operation by cutting
>> power to the SoC, the only possibly wake-up sources are thus the ones
>> connected to the PMIC.
>>
>> Document and add support for an "arm,psci-system-suspend-is-power-down"
>> DT property, so Linux uses a different suspend method when other wake-up
>> sources (e.g. wake on LAN, UART or GPIO) are enabled.
>
> Should we make PSCI return that information? (At least in next
> specification version?)

That's a possible solution.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
