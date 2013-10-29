From: B42378@freescale.com (Chen Guangyu-B42378)
Date: Tue, 29 Oct 2013 12:53:35 +0000
Subject: [PATCH 2/3] ASoC: fsl_ssi: Add dual fifo mode support
In-Reply-To: <526FAD41.2000805@tabi.org>
References: <cover.1383047327.git.b42378@freescale.com>
 <02f8867363ed3038a0a70703856e4b642fef4339.1383047327.git.b42378@freescale.com>,
 <526FAD41.2000805@tabi.org>
Message-ID: <flq2m8se8fxm4icha4yrpcbn.1383051217235@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without dual fifo support,  handware underrun would occasionally occur and then two audio channels would physically swap. This could be easily reproduced in low bus frequency situation, while it would be better if we enable dual fifo.

Sent by Android device.

Timur Tabi <timur@tabi.org> wrote:


Nicolin Chen wrote:
> By enabling dual fifo mode, it would allow SSI enter a better performance
> to transimit/receive data without occasional hardware underrun/overrun.

Have you measured any real performance gain with this patch?  I
considered adding dual-FIFO support when I originally wrote this driver,
but it didn't appear to have any real benefit, but it used twice as many
DMA channels.

I'm concerned that this is another patch that just enables a useless
feature.
