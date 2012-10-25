From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Oct 2012 11:27:36 +0000
Subject: [PATCH 1/2] arm: mvebu: increase atomic coherent pool size for
 armada 370/XP
In-Reply-To: <1351086561-13569-2-git-send-email-gregory.clement@free-electrons.com>
References: <1351086561-13569-1-git-send-email-gregory.clement@free-electrons.com>
 <1351086561-13569-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <201210251127.36960.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 October 2012, Gregory CLEMENT wrote:
> For Armada 370/XP we have the same problem that for the commit
> cb01b63, so we applied the same solution: "The default 256 KiB
> coherent pool may be too small for some of the Kirkwood devices, so
> increase it to make sure that devices will be able to allocate their
> buffers with GFP_ATOMIC flag"
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Do you know why the ATA driver needs this? I find it surprising that
it's necessary, so I'd like to make sure we're not just working around
a device driver bug here.

	Arnd
