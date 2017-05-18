From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 18 May 2017 10:25:23 +0800
Subject: [PATCH] clk: sunxi-ng: enable SUNXI_CCU_MP for PRCM
In-Reply-To: <20170517212035.3100471-1-arnd@arndb.de>
References: <20170517212035.3100471-1-arnd@arndb.de>
Message-ID: <CAGb2v67EHRVrbR9dsNtMuuG+L11WxHcoqVw4GyyD0-hhJ3EPnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 5:19 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The newly added PRCM CCU driver uses SUNXI_CCU_MP_WITH_MUX_GATE, which causes
> a link error when no other driver enables SUNXI_CCU_MP:
>
> drivers/clk/built-in.o:(.data+0x5c8c8): undefined reference to `ccu_mp_ops'
>
> This adds an explicit 'select' statement for it.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
