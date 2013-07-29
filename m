From: broonie@kernel.org (Mark Brown)
Date: Mon, 29 Jul 2013 20:48:29 +0100
Subject: [Ksummit-2013-discuss] Defining schemas for Device Tree
In-Reply-To: <20130729172339.GT29916@titan.lakedaemon.net>
References: <2469263.vMN09Q7Tzi@flatron>
 <20130729150124.GS29916@titan.lakedaemon.net>
 <20130729164905.GB2280@localhost.localdomain>
 <20130729172339.GT29916@titan.lakedaemon.net>
Message-ID: <20130729194829.GG9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 01:23:39PM -0400, Jason Cooper wrote:

> true, the answer to this problem may be to create a depgraph of the
> nodes based on phandles and child status, then init.  However, if the
> goal is to accelerate boot times, then that should not be calculated
> during each boot, especially since it doesn't likely change from boot to
> boot.

FWIW this is broadly speaking what deferred probing is supposed to do -
it seemed too complex and fragile to make the graph for board files so
Grant came up with the idea of deferred probing which aims to sidestep
the problem and work it out dynamically, also providing a fallback in
case something that has actually optimised the ordering misses some case
(cleaning up after the effects of parallel probes for example).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130729/2f39878e/attachment.sig>
