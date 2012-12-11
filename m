From: davem@davemloft.net (David Miller)
Date: Tue, 11 Dec 2012 13:30:58 -0500 (EST)
Subject: [PATCH v2 1/1] net: ethernet: davinci_cpdma: Add boundary for
 rx and tx descriptors
In-Reply-To: <1355197433-7492-1-git-send-email-mugunthanvnm@ti.com>
References: <1355197433-7492-1-git-send-email-mugunthanvnm@ti.com>
Message-ID: <20121211.133058.2238010228178961245.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


You cannot do this.

After your changes the driver no longer does any TX flow control.

It never stops the TX queue and never wakes it up later.

It just drops packets on the floor when it runs out of descriptors.

This breaks everything, and in particular packet schedulers and
TCP.

I'm not applying this.
