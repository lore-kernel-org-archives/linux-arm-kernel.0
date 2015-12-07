From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 7 Dec 2015 21:18:05 +0100
Subject: [PATCH v2 6/6] arm64: renesas: r8a7795: Add L2 cache-controller
 nodes
In-Reply-To: <20151207190355.GE28024@leverpostej>
References: <1449512659-16688-1-git-send-email-geert+renesas@glider.be>
 <1449512659-16688-7-git-send-email-geert+renesas@glider.be>
 <5665D4C7.1050705@arm.com> <20151207190355.GE28024@leverpostej>
Message-ID: <CAMuHMdWrXiYkcFwSkgbEfQRXvT2FsSTbqD72vtiedmeEZZKxLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Mon, Dec 7, 2015 at 8:03 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Dec 07, 2015 at 06:49:43PM +0000, Sudeep Holla wrote:
>> On 07/12/15 18:24, Geert Uytterhoeven wrote:
>> >+    L2_CA57: cache-controller at 0 {
>> >+            compatible = "cache";
>> >+            arm,data-latency = <4 4 1>;
>> >+            arm,tag-latency = <3 3 3>;
>>
>> Interesting, only PL2xx/3xx cache controller driver reads this from the
>> DT and configures the controller. The integrated L2 found in
>> A15/A7/A57/A53 needs doesn't make use of these values from the DT.
>
> These properties seem to be from l2cc.txt, which really only corresponds
> to PL210/PL220/PL310 (and variants) and isn't as generic as it sounds.
>
> I don't see that these are necessary at all.

The datasheet does mention the data/tag RAM latencies/setup values, so
I put them in DT using the properties I could fine.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
