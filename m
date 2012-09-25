From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 25 Sep 2012 07:35:42 +0200
Subject: [PATCH 5/6] ARM: dove: Remove watchdog from DT
In-Reply-To: <1348531338-16624-6-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1348531338-16624-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1348531338-16624-6-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20120925053542.GK14266@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 02:02:17AM +0200, Sebastian Hesselbarth wrote:
> The watchdog on dove requires an interrupt that is not yet
> available on DT. Therefore, the watchdog DT node is removed
> until the corresponding chained intc is available.

Hi Sebastian

Just for my understanding: Is the problem here:

	/* Clear watchdog timer interrupt */
	reg = readl(BRIDGE_CAUSE);
	reg &= ~WDT_INT_REQ;
	writel(reg, BRIDGE_CAUSE);

I ask, because there is no need to pass an interrupt in the DT node.

It is clear to me that bit of code above needs cleaning up sometime
soon.

	Thanks
		Andrew
