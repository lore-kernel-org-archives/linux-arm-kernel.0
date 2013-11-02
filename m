From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 02 Nov 2013 14:26:53 +0100
Subject: [PATCHv9 01/43] clk: Add support for regmap register read/write
In-Reply-To: <1382716658-6964-2-git-send-email-t-kristo@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
 <1382716658-6964-2-git-send-email-t-kristo@ti.com>
Message-ID: <62888417.HVneXSeQuy@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tero,

On Friday 25 of October 2013 18:56:55 Tero Kristo wrote:
> Previously, only direct register read/write was supported. Now a
> per-clock regmap can be provided for same purpose, which allows the
> clock drivers to access clock registers behind e.g. I2C bus.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/clk/clk-divider.c    |    6 +++---
>  drivers/clk/clk-gate.c       |    6 +++---
>  drivers/clk/clk-mux.c        |    6 +++---
>  include/linux/clk-provider.h |   23 +++++++++++++++++++----
>  4 files changed, 28 insertions(+), 13 deletions(-)

The idea itself sounds not bad, but patch description fails to specify 
what is the need for this. I mean, if you know that this will have some 
actual users, it is nice to specify them.

Also IMHO the variant with clk_reg_ops (but with regmap used) would look a 
bit better in terms of readability and extensibility, but I'm leaving this 
completely to Mike's decision.

(OR maybe you could migrate this fully to regmap, which can do MMIO 
accesses as well, without the need of having separate code paths for both 
in clock code?)

Best regards,
Tomasz
