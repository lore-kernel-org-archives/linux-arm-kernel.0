From: olof@lixom.net (Olof Johansson)
Date: Fri, 31 May 2013 23:43:13 -0700
Subject: [PATCH] ARM: bcm2835: override the HW UART periphid
In-Reply-To: <1369886859-22114-1-git-send-email-swarren@wwwdotorg.org>
References: <1369886859-22114-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130601064313.GA9010@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 10:07:39PM -0600, Stephen Warren wrote:
> From: Jongsung Kim <neidhard.kim@lge.com>
> 
> Stephen Warren reported the recent commit 78506f2 (add support for
> extended FIFO-size of PL011-r1p5) breaks the serial port on the
> BCM2835 ARM SoC.
> 
> A UART compatible with the ARM PL011-r1p5 should have 32-deep FIFOs.
> The BCM2835 UART just looks like an ARM PL011-r1p5, but has 16-deep
> FIFOs just like PL011-r1p4 or earlier revisions. As a workaround for
> this compatibility issue, this patch overrides the HW UART periphid
> register values with the actually compatible UART periphid 0x00241011
> (r1p3 or r1p4).
> 
> Reported-by: Stephen Warren <swarren@wwwdotorg.org>
> Signed-off-by: Jongsung Kim <neidhard.kim@lge.com>
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
> This is a fix for v3.10-rc*.

Applied.


-Olof
