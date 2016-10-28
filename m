From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 27 Oct 2016 18:41:27 -0700
Subject: [PATCH v3 1/2] clk: imx: fix integer overflow in AV PLL round rate
In-Reply-To: <4d2e3a91dfb74209735c940b51d7efc9ba2ed69b.1476267249.git.emil@limesaudio.com>
References: <cover.1476267249.git.emil@limesaudio.com>
 <4d2e3a91dfb74209735c940b51d7efc9ba2ed69b.1476267249.git.emil@limesaudio.com>
Message-ID: <20161028014127.GD16026@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12, Emil Lundmark wrote:
> Since 'parent_rate * mfn' may overflow 32 bits, the result should be
> stored using 64 bits.
> 
> The problem was discovered when trying to set the rate of the audio PLL
> (pll4_post_div) on an i.MX6Q. The desired rate was 196.608 MHz, but
> the actual rate returned was 192.000570 MHz. The round rate function should
> have been able to return 196.608 MHz, i.e., the desired rate.
> 
> Fixes: ba7f4f557eb6 ("clk: imx: correct AV PLL rate formula")
> Cc: Anson Huang <b20788@freescale.com>
> Signed-off-by: Emil Lundmark <emil@limesaudio.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
