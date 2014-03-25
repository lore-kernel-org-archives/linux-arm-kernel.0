From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 25 Mar 2014 22:22:58 +0100
Subject: [PATCH v3] clk: berlin: add support for berlin plls
In-Reply-To: <1395775772-19685-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1395775772-19685-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <5331F3B2.9000602@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2014 08:29 PM, Alexandre Belloni wrote:
> This drivers allows to provide DT clocks for the cpu and system PLLs found on
> Marvell Berlin SoCs.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Tested on BG2 and BG2CD, therefore

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> ---
> Changes in v3:
>  - removed empty lines a the end of the files
>  - vcodiv are now arrays filled with zeros by default
>  - use an u64 temporary variable to calculate the rate
>  - warn when refdiv or vcodiv are zero
> 
> ---
>  drivers/clk/Makefile              |   1 +
>  drivers/clk/berlin/Makefile       |   4 ++
>  drivers/clk/berlin/common.h       |  35 ++++++++++++
>  drivers/clk/berlin/pll-berlin2.c  |  40 +++++++++++++
>  drivers/clk/berlin/pll-berlin2q.c |  40 +++++++++++++
>  drivers/clk/berlin/pll.c          | 114 ++++++++++++++++++++++++++++++++++++++
>  6 files changed, 234 insertions(+)
>  create mode 100644 drivers/clk/berlin/Makefile
>  create mode 100644 drivers/clk/berlin/common.h
>  create mode 100644 drivers/clk/berlin/pll-berlin2.c
>  create mode 100644 drivers/clk/berlin/pll-berlin2q.c
>  create mode 100644 drivers/clk/berlin/pll.c
