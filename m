From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 Jun 2014 11:38:50 +0200
Subject: [PATCH v2 04/20] clk: sunxi: Fix gate indexing for
 sun6i-a31-apb0-gates
In-Reply-To: <1403016777-15121-5-git-send-email-wens@csie.org>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
 <1403016777-15121-5-git-send-email-wens@csie.org>
Message-ID: <20140618093850.GJ19730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 10:52:41PM +0800, Chen-Yu Tsai wrote:
> sun6i-a31-apb0-gates supports using clock-indices for holes between
> individual gates. However, the driver passes the number of gates
> registered in clk_data->clk_num, which of_clk_src_onecell_get uses
> to recognize the range of valid indices a consumer can use.
> 
> This patch makes the driver pass the maximum gate index + 1, so
> of_clk_src_onecell_get does not complain about indices greater
> than gates registered.
> 
> This was tested on the A23 SoC, which has a similar APB0 clock,
> but has holes for gates to removed IP blocks.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/75902010/attachment.sig>
