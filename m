From: horms@verge.net.au (Simon Horman)
Date: Thu, 18 Jul 2013 08:01:13 +0900
Subject: [PATCH v4 1/3] ARM: shmobile: r8a7790: add Ether support
In-Reply-To: <20130717091103.GD15981@e106331-lin.cambridge.arm.com>
References: <1372663234-13486-1-git-send-email-horms+renesas@verge.net.au>
 <1372663234-13486-2-git-send-email-horms+renesas@verge.net.au>
 <20130717091103.GD15981@e106331-lin.cambridge.arm.com>
Message-ID: <20130717230113.GA8154@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 10:11:03AM +0100, Mark Rutland wrote:

[snip]

> Why are we hardcoding the address and interrupt of a device rather than
> describing it in the devicetree? This is the most trivial case to
> describe.

The approach that shmobile is taking is to either initialise a device
entirely using C (non-DT) or entirely using DT. And moreover to either
initialise a board using C or DT (though in the latter case some devices
still end up being initialised in C to provide a minimally working system).

At this time for more recent boards we typically provide both a C and DT
versions to initialise a board. The C version typically is able to
initialise a fuller set of hardware while the DT version catches up.

In this case the device is being initialised in C. And this code is
intended ti be used when a board and thus its SoC is initialised using C.

Once the SH ethernet driver and all its pre-requisite drivers and
infrastructure can be initialised using DT then that will be used when
initialising the board using DT.
