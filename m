From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 2 Feb 2016 14:17:25 +0100
Subject: [PATCH 04/14] clk: sunxi: add ahb1 clock for A83T
In-Reply-To: <1454203266-4450-5-git-send-email-vishnupatekar0510@gmail.com>
References: <1454203266-4450-1-git-send-email-vishnupatekar0510@gmail.com>
 <1454203266-4450-5-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <20160202131725.GQ4652@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jan 31, 2016 at 09:20:56AM +0800, Vishnu Patekar wrote:
> AHB1 on A83T is similar to ahb1 on A31, except parents are different.
> clock index 0b1x is PLL6.
> 
> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>

If the clock is the same but the parents are different, then we don't
need to duplicate all the logic. Simply add the number of parents to
mux_data, and you're all set.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160202/170676f2/attachment.sig>
