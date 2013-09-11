From: b32955@freescale.com (Huang Shijie)
Date: Wed, 11 Sep 2013 10:38:02 +0800
Subject: [PATCH v3 0/8] Add the Quadspi driver for vf610-twr
In-Reply-To: <20130910180704.GB29403@sirena.org.uk>
References: <593AEF6C47F46446852B067021A273D6D984000B@MUCSE039.lantiq.com>
 <20130905020435.GA3970@gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA0C7F4@DBDE04.ent.ti.com>
 <522817D7.1010206@freescale.com> <522D3B79.3060707@freescale.com>
 <20130909151450.GI29403@sirena.org.uk> <522EC33B.9000009@freescale.com>
 <20130910180704.GB29403@sirena.org.uk>
Message-ID: <522FD78A.6080900@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?09?11? 02:07, Mark Brown ??:
> The code to work out what opcodes to send to the device should be split
> out of the device driver so that other drivers talking to these chips
this code should be in the MTD code, not in the drivers.
I have spilted this code, please see patch 3 & patch 4.


> don't need to reimplement the logic and new chips with new opcodes don't
> need to be added to multiple drivers.
Since there is no standard for SPI-NOR commands, we _should_ add new
code for
new chips with new opcodes. For example, if a new chip supports the
quad-read with
a new command 0xef, we can submit a small patch for m25p80 to fix it.

We have to do it in such way, no shortcut.


thanks
Huang Shijie
