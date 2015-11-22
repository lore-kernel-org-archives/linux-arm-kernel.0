From: peter.maydell@linaro.org (Peter Maydell)
Date: Sun, 22 Nov 2015 13:29:29 +0000
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <12750898.0A5czJmNqv@wuerfel>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <yw1x4mgfc89z.fsf@unicorn.mansr.com> <4519802.lamVCN5F0B@wuerfel>
 <12750898.0A5czJmNqv@wuerfel>
Message-ID: <CAFEAcA-r_zi0-Q9=sT0YTQJ-HGYzLmoWNqtqN6ZV=01qOeCCMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 November 2015 at 23:21, Arnd Bergmann <arnd@arndb.de> wrote:
> Regarding PJ4, it's still unclear whether that has the same
> problem and it only reports idivt when it actually supports idiva,
> or whether the lack of idiva support on PJ4 is instead the reason
> why the ARM ARM was updated to have separate flags.

SDIV/IDIV were originally introduced for R and M profile only
and there the Thumb encodings of SDIV/IDIV are mandatory
whereas the ARM ones are optional (and weren't initially
defined at all). So if you're looking for CPUs with only the
Thumb encodings I would try checking older R profile cores
like the Cortex-R4.

thanks
-- PMM
