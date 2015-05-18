From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 18 May 2015 07:54:21 +0200
Subject: [PATCH v2] clk: mediatek: Initialize clk_init_data
In-Reply-To: <1431920513-1491-1-git-send-email-jcliang@chromium.org>
References: <1431920513-1491-1-git-send-email-jcliang@chromium.org>
Message-ID: <20150518055421.GL6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ricky,

On Mon, May 18, 2015 at 11:41:49AM +0800, Ricky Liang wrote:
> The variable init (struct clk_init_data) is allocated on the stack.
> We weren't initializing the .flags field, so it contains random junk,
> which can cause all kinds of interesting issues when the flags are
> parsed by clk_register.

It seems we have the same problem in clk-gate.c aswell. We do initialize
do .flags field there, so this is no urgent problem, but we might get a
real problem when additional fields are added to struct clk_init_data.
Care to fix that aswell along with this patch?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
