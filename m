From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Dec 2013 10:17:26 +0800
Subject: [PATCHv6 2/5] clk: socfpga: Add a clock type for the SD/MMC driver
In-Reply-To: <52AF68DB.7090105@elopez.com.ar>
References: <1386880245-10192-1-git-send-email-dinguyen@altera.com>
 <1386880245-10192-3-git-send-email-dinguyen@altera.com>
 <201312142233.27143.arnd@arndb.de>
 <52AD1185.6090501@linaro.org> <20131215045116.23538.4@quantum>
 <52AF68DB.7090105@elopez.com.ar>
Message-ID: <CAGb2v67dud7XQSOy4eABX3SZX9pRkm366dodke5-AzdcGuje5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 17, 2013 at 4:55 AM, Emilio L?pez <emilio@elopez.com.ar> wrote:
> I also saw a similar requirement from the gmac people (on cc too), who
> needed to set the phy type (or something like that) on one of the clock

The GMAC clock register controls the tx clock source (a mux) and the
interface type, which is most likely a gate to control the direction
of the tx clock.

So I modeled it as a composite clock source for now.
I'm open to other options.

> registers; so I'm thinking maybe a generic "tune something" approach that
> lets users configure some clock-dependent, arbitrary aspect of the clock is
> the way forward. Otherwise, we're going to end up bloating the clock
> framework with a lot of callback pointers that are going to be used in one
> or two clocks out of potentially hundreds on the whole system.

ChenYu
