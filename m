From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 30 Sep 2013 23:16:50 +0200
Subject: [PATCH 0/4] Kirkwood: minor cleanups
In-Reply-To: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130930211650.GF6735@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The third and fourth patch are related: the latter strictly depends on
> the former. The idea behind these two patches is basically to convert
> the "keep the ethernet clocks enabled by calling clk_enable()" hack
> into a simpler and cleaner usage of the CLK_IGNORE_UNUSED flags which
> prevent these clocks from being ever gated.

Hi Ezequiel

This should work, but what would be nicer is to look and see if there
is a node in DT for each device. If it does not have a node, don't set
CLK_IGNORE_UNUSED, so that the clock does get turned off, and we save
a bit of power. Quite a few of the kirkwood devices only have one
ethernet.

	Andrew
