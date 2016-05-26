From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 26 May 2016 09:03:33 +0200
Subject: [PATCH v3 1/3] arm64: dts: r8a7796: Add Renesas R8A7796 SoC
 support
In-Reply-To: <edee7345-280a-0d7c-7e5a-798215fbd2b9@de.bosch.com>
References: <1464054880-25843-1-git-send-email-horms+renesas@verge.net.au>
 <1464054880-25843-2-git-send-email-horms+renesas@verge.net.au>
 <b30c9c84-23b6-b088-4983-b2498317492b@de.bosch.com>
 <20160525004825.GC7292@verge.net.au>
 <c0fd13d5-c5c4-579b-6fad-c637bda92398@de.bosch.com>
 <edee7345-280a-0d7c-7e5a-798215fbd2b9@de.bosch.com>
Message-ID: <CAMuHMdXnN-GTN4crXeWRvtWT4E2kYFvMdPPcH8z+gJb-B4PbYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dirk,

On Wed, May 25, 2016 at 9:32 AM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
> P.S.: This also results in the question why we need similar
> r8a7795-cpg-mssr.h and r8a7796-cpg-mssr.h with just different "numbers" for
> the same clocks. Can't we use the same numbers on all SoCs, with just having
> wholes in the list where the clocks don't exist on a SoC? I haven't looked

The CPG and MSSR block are the IP blocks that differ most among SoCs of the
same family. Some clocks are present on H3 only, others on M3-W only.

Having a shared driver core, but different defines, is a compromise between
reusability and avoiding mistakes in DTSes (e.g. pointing to a nonexisting
clock due to copy and paste from another SoC).

> into the manual if these numbers are given by the hardware, though.

The actual numbers don't map to numbers in the datasheet, just to an unordered
list in a table. The list of number is considered part of the DT bindings, and
thus append-only (to be considered in case the datasheet is updated).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
