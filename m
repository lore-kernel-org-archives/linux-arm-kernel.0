From: abrestic@chromium.org (Andrew Bresticker)
Date: Mon, 3 Jun 2013 16:46:09 -0700
Subject: [PATCH V4 2/4] clk: samsung: register audio subsystem clocks
 using common clock framework
In-Reply-To: <CAD=FV=XOfi=BsaF+-96SqKwyiwP9h0h3MCJxJ+qWNKaGoP=CcA@mail.gmail.com>
References: <1370236744-16802-1-git-send-email-padma.v@samsung.com>
 <1370236744-16802-3-git-send-email-padma.v@samsung.com>
 <CAD=FV=XOfi=BsaF+-96SqKwyiwP9h0h3MCJxJ+qWNKaGoP=CcA@mail.gmail.com>
Message-ID: <CAL1qeaEkomoDQPyGqqLL-WzoLS=nND-eXeRAGD2HpoV6WW3yRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +static unsigned long reg_save[][2] = {
>> +       {ASS_CLK_SRC,  0},
>> +       {ASS_CLK_DIV,  0},
>> +       {ASS_CLK_GATE, 0},
>> +};
>> +
>> +/* list of all parent clock list */
>> +static const char *mout_audss_p[] = { "fin_pll", "fout_epll" };
>
> I think this is supposed to be "xxti" which might or might not be
> "fin_pll".  In the exynos4 code these are two different clocks that
> are chosen by OM[0].  I'd bet that 99% of the time they are the same,
> but it seems better to use "xxti".

OM[0] also appears to mux the input here between "xxti" and "xusbxti"
as well.  So this should probably remain "fin_pll".

> At the moment the 5250 code doesn't expose "xxti".  It probably
> should.  Andrew (CCed) is looking at this.

Yes, xxti is used directly elsewhere (SPI and UART, from what I can
tell), but not here.

-Andrew
