From: pza@pengutronix.de (Philipp Zabel)
Date: Thu, 15 Jun 2017 23:55:50 +0200
Subject: [PATCH 2/2 v4] clk: Add Gemini SoC clock controller
In-Reply-To: <CACRpkdY+aSyec9PZaoXErzsRefWg2zzw1xihQt_whmote-jBBw@mail.gmail.com>
References: <20170524082044.8473-1-linus.walleij@linaro.org>
 <20170601070208.GO20170@codeaurora.org>
 <CACRpkdZv8MzXVecEXVdJ+P0MxVscYSy=MxC-yQAR0S4yQ6-rwQ@mail.gmail.com>
 <20170605195812.GH20170@codeaurora.org>
 <CACRpkdbya9xaN-i7AkG0bTyuFYfZc59sSTYhWB43=9btSKfPpQ@mail.gmail.com>
 <CACRpkdapAgHix2vw-woDFi4sh+H3_EX7w-5q=opBGMyegFrXbA@mail.gmail.com>
 <20170612210248.GP20170@codeaurora.org>
 <CACRpkdaZJbzC0-xg_go=-o+0cQ-JOY3mUe27HUnwQ+DnZYbyMA@mail.gmail.com>
 <CAMuHMdXdYNTLCUfQ9rdj8Fffff5G6fGREcHs5-E5LbwPU9yyLw@mail.gmail.com>
 <CACRpkdY+aSyec9PZaoXErzsRefWg2zzw1xihQt_whmote-jBBw@mail.gmail.com>
Message-ID: <20170615215550.z4ypeh345gopd2pg@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Thu, Jun 15, 2017 at 02:57:53PM +0200, Linus Walleij wrote:
> On Thu, Jun 15, 2017 at 10:55 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> 
> > If clocks and resets are provided by the same hardware module, you can
> > have a single (platform) driver registering both the clock and reset
> > controllers.
> > Cfr. drivers/clk/renesas/renesas-cpg-mssr.c.
> 
> That is indeed an option.
> 
> So I would say, clk & reset maintainers: would you prefer that I merge the
> reset control into the clock driver as well, ask Philipp to drop the pending
> reset control patches from his subsystem tree and have you manage the
> combined driver and bindings?

The reset/next pull requests are not merged into the arm-soc tree yet.
I suppose I could retract the pull requests and drop the Gemini reset
patches, if the patches in arm-soc/gemeni/dts are also dropped from
arm-soc/for-next.

> It seems to me as very ugly from a divide & conquer subsystem and file
> split point of view.
>
> I seems elegant from the "make clocks a platform device" point of view.
> 
> I am happy with either approach as long as it works.
> 
> I guess it is up to the taste of the subsystem maintainers, especially
> clk.
>
> If I get some time I might just hack this up and send the patches so
> it is on the table as an alternative to the current v5 patch. Certainly it is
> better than going back and augmenting the DT bindings.

I have a slight preference for keeping the DT bindings simple, even if
that means merging the reset controller into the clock driver.

regards
Philipp
