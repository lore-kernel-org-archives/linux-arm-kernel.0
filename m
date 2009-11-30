From: javier.martin@vista-silicon.com (javier Martin)
Date: Mon, 30 Nov 2009 17:40:38 +0100
Subject: [PATCH 1/3] ASoC: Add a new imx-ssi sound driver
In-Reply-To: <20091125155807.GD12750@rakim.wolfsonmicro.main>
References: <1259163666-30344-1-git-send-email-s.hauer@pengutronix.de>
	<1259163666-30344-2-git-send-email-s.hauer@pengutronix.de>
	<20091125155807.GD12750@rakim.wolfsonmicro.main>
Message-ID: <eedb5540911300840p230fc57fh3fd5c8453b0e1f73@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sascha,
in "imx_ssi_set_dai_fmt()" callback you should add something like:

    /* sync */
    scr |= SSI_SCR_SYN;

This would enable SSI working in SYN mode which means that RX and TX
sections will share same frame and bit clocks. Right now I can't imagine a
situation where this is not desirable. Moreover, if I don't add SYN mode I
cannot get it working in my i.mx27 based board with an wm8974.

With this line it works flawlessly, good job.

Thanks.
-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091130/d8ff866f/attachment-0001.htm>
