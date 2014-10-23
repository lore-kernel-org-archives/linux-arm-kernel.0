From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 23 Oct 2014 16:05:57 +0200
Subject: ARMADA 370 - Distributed Switch Architecture (dsa) - device tree
In-Reply-To: <3328a23fffe41f90f0660b26e36e412a@twien.net>
References: <f1e8d1ba750bfb63f84471d0ec7de988@twien.net>
 <20141013111904.GD14147@titan.lakedaemon.net>
 <20141023112002.228d8a17@free-electrons.com>
 <20141023121034.GJ17447@titan.lakedaemon.net>
 <3328a23fffe41f90f0660b26e36e412a@twien.net>
Message-ID: <20141023140557.GD25190@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 23, 2014 at 02:57:45PM +0200, post at twien.net wrote:
> Hello all,
> It's progressing. Have had little time to work on it lately, but
> have got the 6352 switch up and running except for port 6 (the one
> with external PHY). It's currently commented out in my device tree
> specification. Enabling port 6 in the .dts file causes the dsa setup
> to fail (error -5).

What kernel version are you using?

I recently swapped to 3.18-rc1 and my DIR665 is no longer doing
correct auto-negotiation. The interfaces come up 10/half duplex, and i
need to restart autoneg with ethtool before i get full Gbps.  So it
looks like there is something wrong with phys somewhere.

      Andrew
