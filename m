From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 10 Jun 2016 22:42:03 +0200
Subject: [PATCH 07/13] ARM: dts: r8a7792: initial SoC device tree
In-Reply-To: <8efb1c7e-5463-2556-744c-d327886d92d4@cogentembedded.com>
References: <13205049.n7pM8utpHF@wasted.cogentembedded.com>
 <2539026.OyU5nvpxa6@wasted.cogentembedded.com>
 <20160601005751.GG20527@verge.net.au>
 <fdab2628-60bd-c41b-296b-38cd71a6c5da@cogentembedded.com>
 <CAMuHMdUkOpEp+YCbZVZppdN4C7KKpDS9_gEuXi_WKZXM9YHgEQ@mail.gmail.com>
 <ab5e3a98-7ff2-dc8f-d255-f6da26f43527@cogentembedded.com>
 <20160610010245.GA10152@verge.net.au>
 <8efb1c7e-5463-2556-744c-d327886d92d4@cogentembedded.com>
Message-ID: <CAMuHMdUK=y2kZY1kA97QpCDyUZXFejpXTpO9ZVNQoBfDNoRgfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Fri, Jun 10, 2016 at 9:29 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>    The only problem I'm seeing (again) is the RCAN clock failing to
> register:
>
> rcar_gen2_cpg_clocks_init: failed to register cpg_clocks rcan clock (-12)
>
>    I was going to look at it yesterday but (wrongly) thought it somehow
> cured itself... I'll look at it now.

The RCAN parent is the second clock in the CPG node's "clocks" property,
which you didn't provide.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
