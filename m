From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 9 Apr 2015 17:18:46 +0200
Subject: [PATCH 0/2] crypto: add new driver for Marvell CESA
In-Reply-To: <1428591523-1780-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1428591523-1780-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150409151846.GE1459@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 04:58:41PM +0200, Boris Brezillon wrote:
> Hello,
> 
> This is an attempt to replace the mv_cesa driver by a new one to address
> some limitations of the existing driver.
> >From a performance and CPU load point of view the most important
> limitation is the lack of DMA support, thus preventing us from chaining
> crypto operations.
> 
> I know we usually try to adapt existing drivers instead of replacing them
> by new ones, but after trying to refactor the mv_cesa driver I realized it
> would take longer than writing an new one from scratch.

Hi Boris

What is the situation with backwards compatibility? I see you have
kept the old compatibility string, and added lots of new ones, and
deprecated some properties. Will an old DT blob still work?
 
 Thanks
	Andrew
