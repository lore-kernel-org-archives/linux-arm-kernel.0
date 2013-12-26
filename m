From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 26 Dec 2013 22:34:52 +0100
Subject: [PATCH V2 2/5] arm: shmobile: r7s72100: add i2c clocks
In-Reply-To: <20131226212539.GA2561@katana>
References: <1387402321-21866-1-git-send-email-wsa@the-dreams.de>
 <1387402321-21866-3-git-send-email-wsa@the-dreams.de>
 <20131224024855.GC22401@verge.net.au>
 <CAMuHMdWPZjeF7+nEjXR3vL4HgSEVEk-uf-qQ68ZnFA=+Y_Q8tQ@mail.gmail.com>
 <20131226212539.GA2561@katana>
Message-ID: <CAMuHMdXF6WmS_j4pC1U5jL3SK-ck7N=EA+-45duXdRZP1cOJkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 26, 2013 at 10:25 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Thu, Dec 26, 2013 at 10:20:23PM +0100, Geert Uytterhoeven wrote:
>> On Tue, Dec 24, 2013 at 3:48 AM, Simon Horman <horms@verge.net.au> wrote:
>> > On Wed, Dec 18, 2013 at 10:31:58PM +0100, Wolfram Sang wrote:
>> >> From: Wolfram Sang <wsa@sang-engineering.com>
>> >>
>> >> Tested with RIIC2 on a genmai board. Others untested but hopefully
>> >> trivial enough to be added.
>> >>
>> >> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
>> >> Acked-by: Magnus Damm <damm@opensource.se>
>> >> ---
>> >>
>> >> V2: adapt to established sorting
>> >
>> > Thanks. This seems safe enough and I will queue it up.
>>
>> Note that after dropping these lines:
>>
>>        CLKDEV_DEV_ID("fcfee000.i2c", &mstp_clks[MSTP97]),
>>        CLKDEV_DEV_ID("fcfee400.i2c", &mstp_clks[MSTP96]),
>>        CLKDEV_DEV_ID("fcfee800.i2c", &mstp_clks[MSTP95]),
>>        CLKDEV_DEV_ID("fcfeec00.i2c", &mstp_clks[MSTP94]),
>>
>> i2c stopped working.
>
> ??? Why do you want to drop these lines?

Your v2 dropped them, presumably in response to Sergei's ICKy comments.
And that's what Simon committed...

> If the i2c clocks are not registered, you won't get i2c support? Am I
> missing something?

Ah OK. So you do need them. Good, /me getting less confused ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
