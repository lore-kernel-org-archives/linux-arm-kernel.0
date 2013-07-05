From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 5 Jul 2013 20:35:42 +0800
Subject: [PATCH v4] tty: serial: add Freescale lpuart driver support
In-Reply-To: <B56CDBE15CE27145A4B77D2D24263E851E5AFC@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1369733161-19168-1-git-send-email-b35083@freescale.com>
 <20130705091449.GA20040@S2101-09.ap.freescale.net>
 <B56CDBE15CE27145A4B77D2D24263E851E5AFC@039-SN1MPN1-005.039d.mgd.msft.net>
Message-ID: <20130705123541.GB20040@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 05, 2013 at 09:39:03AM +0000, Lu Jingchang-B35083 wrote:
> I explicitly removed the cr2 restore code on cleaning up the redundant code, and find it work well on normal operation.
> Low level debug is not supported on Vybrid so I didn't notice that problem.
> Will you fixing it? Or I submit a fix on it?

I can send a fix for that.  But before doing that, I would need your
help to understand why we need to clear those UARTCR2 bits for setting
up FIFO stuff at all.  From my quick testing, at least console still
works fine after removing all those UARTCR2 operations from
lpuart_setup_watermark().

Shawn
