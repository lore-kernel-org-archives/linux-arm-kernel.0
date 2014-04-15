From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 15 Apr 2014 11:26:20 +0200
Subject: Renesas clock clk-mstp updates for clock-indices
In-Reply-To: <1394196400-17112-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1394196400-17112-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <CAMuHMdVVc-9n4mQSj6qVyP5k9xzSstSw==nfYcFSOXtb895QUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On Fri, Mar 7, 2014 at 1:46 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> Mike, following the commit to add the clock-indices field, the following
> pair of commits updates the shmboile clk-mstp driver to uses these over
> the local variant.
>
> Since this is involves two separte trees which are in development, the
> decision is that we will fixup the renesas trees once they are merged
> and the development cycle is complete. Once this is done, patch 2/2
> can be reverted (if people care about three lines of differrence)

As we now have "renesas,clock-indices" in v3.14, the question about backwards
compatibility became moot.

Can you please combine your two patches

[PATCH 1/2] clk: shmobile: clk-mstp: change to using clock-indices
[PATCH 2/2] clk: shmobile: clk-mstp: add backwards comapt for indices field

into a single patch, and submit to Mike?

Once it's in Mike's clk-next, we can do the following to get everything in
v3.15:
  1. Simon cherry-picks Mike's commit into his fixes-for-v3.15 branch,
  2. we fix arch/arm/boot/dts/r8a7790.dtsi and .../r8a7791.dtsi there,
  3. fixes-for-v3.15 gets into mainline through arm-soc.

Does that sound like plan?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
