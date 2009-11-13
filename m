From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Nov 2009 09:59:37 +0000
Subject: [PATCH] serial21285: fix disable_irq-from-interrupt-handler
	deadlock
In-Reply-To: <20091113090234.7d028820@marrow.netinsight.se>
References: <20091113090234.7d028820@marrow.netinsight.se>
Message-ID: <20091113095937.GA25995@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 13, 2009 at 09:02:34AM +0100, Simon Kagstrom wrote:
> Russell: This patch is a bit of RFC since I'm not quite sure that it's
> the correct solution. It unbreaks booting on our footbridge-based
> platform. Let me know if I should look at other solutions!

It does look like the right thing to do - the original code will hang
now that we're using genirq stuff.
