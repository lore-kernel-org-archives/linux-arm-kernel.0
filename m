From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Dec 2017 09:09:49 +0100
Subject: [PATCH 05/20] ARM: dts: aspeed: Add proper clock references
In-Reply-To: <20171211050704.20621-6-joel@jms.id.au>
References: <20171211050704.20621-1-joel@jms.id.au>
 <20171211050704.20621-6-joel@jms.id.au>
Message-ID: <CAK8P3a10wjXvFpE5zbwCfQNC-UiRCzKE+9-ENg-Sr577ZCF+Xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 6:06 AM, Joel Stanley <joel@jms.id.au> wrote:
> The existing device trees use fixed-clocks in order to boot without a
> clk driver. The newly added clk driver provides proper clock support,
> including gating, so we move the device trees over to properly request
> clocks.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Can you clarify here whether this will break running old kernels with
new DT files or vice versa, and why this is ok here?

I assume you have thought about it carefully, but I'd still like to document
every time we intentionally break compatibility like this. It looks like
you too care to merge the driver changes and the DT binding change first,
so we don't get any bisection problems.

What I'm not completely clear about is the difference between the
"aspeed,g4-scu" binding and the "aspeed,ast2400-scu" binding.
They are listed as equal in
Documentation/devicetree/bindings/mfd/aspeed-scu.txt, so why do you
change it here?

      Arnd
