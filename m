From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Jun 2017 10:38:14 +0200
Subject: [PATCH 2/2 v4] clk: Add Gemini SoC clock controller
In-Reply-To: <20170615215550.z4ypeh345gopd2pg@pengutronix.de>
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
 <20170615215550.z4ypeh345gopd2pg@pengutronix.de>
Message-ID: <CACRpkdbBOnzw5Ww-2TesvDzSV6eiV2y0WyJW-wtLeAszZE-2HQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 15, 2017 at 11:55 PM, Philipp Zabel <pza@pengutronix.de> wrote:
> On Thu, Jun 15, 2017 at 02:57:53PM +0200, Linus Walleij wrote:

>> So I would say, clk & reset maintainers: would you prefer that I merge the
>> reset control into the clock driver as well, ask Philipp to drop the pending
>> reset control patches from his subsystem tree and have you manage the
>> combined driver and bindings?
>
> The reset/next pull requests are not merged into the arm-soc tree yet.
> I suppose I could retract the pull requests and drop the Gemini reset
> patches,

There is no need. You can simply revert the patches, it's OK that the
drivers bounce in and out of the kernel.

The clock driver will just probe instead of the reset driver (due to being
earlier in the link order... OK fragile but it works), so there
will not even be a runtime conflict.

> if the patches in arm-soc/gemeni/dts are also dropped from
> arm-soc/for-next.

There is no need for that, the bindings do not change with this approach.

> I have a slight preference for keeping the DT bindings simple, even if
> that means merging the reset controller into the clock driver.

OK then that is what we're gonna do.

I'm onto it!

Yours,
Linus Walleij
