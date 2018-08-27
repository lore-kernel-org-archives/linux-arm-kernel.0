From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 27 Aug 2018 15:07:46 +0200
Subject: [PATCH 2/2] clk: meson-g12a: Add AO Clock controller driver
In-Reply-To: <fff1f982-c9f3-8aa4-b108-6c0998827e79@amlogic.com>
References: <1533894868-85815-1-git-send-email-jian.hu@amlogic.com>
 <1533894868-85815-3-git-send-email-jian.hu@amlogic.com>
 <6c855dc62fe6ed1a01216bd708d401a280f8762c.camel@baylibre.com>
 <fff1f982-c9f3-8aa4-b108-6c0998827e79@amlogic.com>
Message-ID: <89b058a7bba26058fab95dea01155221dbb642ce.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-08-24 at 21:34 +0800, Jian Hu wrote:
> > 
> 
> I am confued about aoclk81's parent clocks.
> 
> I can not get the example of axg audio clock driver, Could you provide 
> the link? Had it merged into clk-meson.git?

Yes and mainline as well : drivers/clk/meson/axg-audio.c

Basically this driver is creating bypass input clocks (audio_pclk, mst_in[0-9],
etc...) .

This allows to collect input clocks from DT (like any consumer should) will
keeping constant in the controller clock tree.

>From what I've seen of your controller drivers, the EE controller should have
one input, the AO should have 3.
