From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Mar 2011 10:15:54 +0000
Subject: [PATCH 2/8] macb: detect hclk presence from platform data
In-Reply-To: <1299751843-9743-3-git-send-email-jamie@jamieiles.com>
References: <1299751843-9743-1-git-send-email-jamie@jamieiles.com>
	<1299751843-9743-3-git-send-email-jamie@jamieiles.com>
Message-ID: <20110310101554.GD11273@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2011 at 10:10:37AM +0000, Jamie Iles wrote:
> Rather than detecting whether we need to do a clk_get() and enable on
> the "hclk" based on the kernel configuration, add an extra field to the
> platform data.  This makes it cleaner to add more supported
> architectures without lots of ifdeffery.

Why not have the platform provide a dummy hclk if no real hclk exists?
