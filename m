From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 22 Nov 2016 12:35:05 +0100
Subject: [PATCH v3] clkdev: Detect errors in clk_hw_register_clkdev() for
 mass registration
In-Reply-To: <CAMuHMdW8V2v7na1c4B=w2qzN=qVF0QUA3fcqaUXdTEVB20JREg@mail.gmail.com>
References: <1477033358-7934-1-git-send-email-geert@linux-m68k.org>
 <20161031092223.GW1041@n2100.armlinux.org.uk>
 <CAMuHMdW8V2v7na1c4B=w2qzN=qVF0QUA3fcqaUXdTEVB20JREg@mail.gmail.com>
Message-ID: <CAMuHMdXE89a1-qzH5Se-w1L2bLknTae7jPQ07q5Zw_nKt7RLPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 31, 2016 at 10:31 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Oct 31, 2016 at 10:22 AM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
>> On Fri, Oct 21, 2016 at 09:02:38AM +0200, Geert Uytterhoeven wrote:
>>> Unlike clk_register_clkdev(), clk_hw_register_clkdev() doesn't check for
>>> passed error objects from a previous registration call. Hence the caller
>>> of clk_hw_register_*() has to check for errors before calling
>>> clk_hw_register_clkdev*().
>>>
>>> Make clk_hw_register_clkdev() more similar to clk_register_clkdev() by
>>> adding this error check, removing the burden from callers that do mass
>>> registration.
>>>
>>> Fixes: e4f1b49bda6d6aa2 ("clkdev: Add clk_hw based registration APIs")
>>> Fixes: 944b9a41e004534f ("clk: ls1x: Migrate to clk_hw based OF and registration APIs")
>>> Fixes: 44ce9a9ae977736f ("MIPS: TXx9: Convert to Common Clock Framework")
>>> Fixes: f48d947a162dfa9d ("clk: clps711x: Migrate to clk_hw based OF and registration APIs")
>>> Fixes: b4626a7f489238a5 ("CLK: Add Loongson1C clock support")
>>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>
>> Please put this in the patch system, thanks.
>
> Done. I hope it went through, the "new" README predates git-send-email.

Still no evidence of the patch having arrived...
Tried the web interface instead, patch is now 8631/1.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
