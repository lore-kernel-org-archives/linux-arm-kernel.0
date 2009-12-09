From: jassisinghbrar@gmail.com (jassi brar)
Date: Wed, 9 Dec 2009 21:31:50 +0900
Subject: [PATCH 3/5] SPI S3C64XX: Header for passing platform data
In-Reply-To: <20091209121643.GD9018@sirena.org.uk>
References: <1259218097-9845-1-git-send-email-jassi.brar@samsung.com>
	<20091203220637.GR4808@trinity.fluff.org>
	<1b68c6790912040306m3098cba9wf67bfe5bfefb7e23@mail.gmail.com>
	<20091207144145.GT4808@trinity.fluff.org>
	<1b68c6790912081750r7a68f019w39a5170c9796e7b9@mail.gmail.com>
	<20091209121643.GD9018@sirena.org.uk>
Message-ID: <1b68c6790912090431x28e1acbbjd2147083c21677c3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 9, 2009 at 9:16 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Dec 09, 2009 at 10:50:16AM +0900, jassi brar wrote:
>
>> ? Second - SPI source clocks specific, which SoCs differ by name and number.
>> ? ? ? ? ? Maybe this could go into plat-<soc>/include with the name
>> ? ? ? ? ? <soc>-spi.h
>
> With device based lookup (which Ben mentioned he was working on) this
> mapping should get handled entirely within the CPU clock tree
> definition and be invisible to the driver.
I meant the following part as SoC specific include:-
  #define S3C64XX_SPI_SRCCLK_PCLK                0
  #define S3C64XX_SPI_SRCCLK_SPIBUS      1
  #define S3C64XX_SPI_SRCCLK_48M         2
  #define BUSNUM(b)              (b)

the rest can be shared across SoCs in common include
