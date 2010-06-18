From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 18 Jun 2010 11:38:04 +0900
Subject: [PATCH] S5PV210 Correct clock register properties
In-Reply-To: <1276763596-6175-1-git-send-email-myungjoo.ham@samsung.com>
References: <1276763596-6175-1-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <001001cb0e8f$47e2a8e0$d7a7faa0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MyungJoo Ham wrote:
> 
> From: MyungJoo Ham <myungJoo.ham@samsung.com>
> 
> Corrected shift values of I2S and UART clocks (CLK_GATE_IP3).
> 
> I2S (CLK_GATE_IP3) and UART (CLK_GATE_IP3) had wrong register shift
> values, which in turn, made them turn on and off wrong clocks.

(snip)

Sorry..kindly ignore below comments.
My mistake..

---
Your point is right..but your updated code was wrong :-(

Should be like below.

@@ -400,19 +400,19 @@ static struct clk init_clocks_disable[] = {
 		.id		= 0,
 		.parent		= &clk_p,
 		.enable		= s5pv210_clk_ip3_ctrl,
-		.ctrlbit	= (1<<4),
+		.ctrlbit	= (1 << 4),
 	}, {
 		.name		= "i2s_v32",
 		.id		= 0,
 		.parent		= &clk_p,
 		.enable		= s5pv210_clk_ip3_ctrl,
-		.ctrlbit	= (1<<4),
+		.ctrlbit	= (1 << 5),
 	}, {
 		.name		= "i2s_v32",
 		.id		= 1,
 		.parent		= &clk_p,
 		.enable		= s5pv210_clk_ip3_ctrl,
-		.ctrlbit	= (1<<4),
+		.ctrlbit	= (1 << 6),
---

(snip)


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
