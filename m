From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Jan 2012 13:02:22 +0000
Subject: [PATCH] ARM: pl330: fix null pointer dereference in
 pl330_chan_ctrl()
In-Reply-To: <1326458191-23492-1-git-send-email-mans.rullgard@linaro.org>
References: <1326458191-23492-1-git-send-email-mans.rullgard@linaro.org>
Message-ID: <20120113130222.GU1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 12:36:31PM +0000, Mans Rullgard wrote:
> This fixes the thrd->req_running field being accessed before thrd
> is checked for null.  The error was introduced in abb959f.
> 
> Signed-off-by: Mans Rullgard <mans.rullgard@linaro.org>

I don't know what's happening with the PL330 driver, but there's patches
around to remove this file and merge it with the DMA engine driver.
