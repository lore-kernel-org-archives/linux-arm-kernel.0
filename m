From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Jun 2014 12:39:39 +0100
Subject: [PATCH 0/3] Deterministic UART numbering on Samsung SoCs
In-Reply-To: <1403781875-5425-1-git-send-email-t.figa@samsung.com>
References: <1403781875-5425-1-git-send-email-t.figa@samsung.com>
Message-ID: <20140626113939.GP32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 01:24:32PM +0200, Tomasz Figa wrote:
> Current Samsung UART driver relies on probe order of particular
> samsung-uart instances, which makes it impossible to get proper
> initialization of ports when not all ports are available on board,
> not even saying of deterministic device naming.
> 
> This series intends to fix this situation by adding support to parse
> aliases from device tree and use them to assign instance IDs to
> particular port instances.

How about instead exporting the path/id information so that userspace
can create /dev/serial/by-{path,id}/... for internal devices instead?

The problem you're raising is very much the same problem you have when
there are multiple USB serial devices connected to the machine - you
just get a bunch of /dev/ttyUSB* devices which are unordered (they can
change on each boot, or change order if you disconnect and reconnect
them.)

/dev/serial/by-{path,id}/ allows for a much more stable path.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
