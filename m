From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Nov 2015 16:57:20 +0100
Subject: [PATCH] ARM: mvebu: add reference to ETH connectors for A385-AP
In-Reply-To: <1447775620-25919-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1447775620-25919-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <7560280.yqEeu9J2fA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 November 2015 16:53:40 Thomas Petazzoni wrote:
> This commit adds some comments to the Armada 385 AP Device Tree
> description to indicate which Ethernet interface matches which
> physical connector on the board.
> 
> This is especially useful on this board, since the mapping between the
> logical interface names and the physical ports is not very
> straightforward. It also doesn't match the numbering of the interfaces
> done by U-Boot:
> 
>  U-Boot interface | Linux interface | Physical port
>  -----------------+-----------------+--------------
>    egiga0         |     eth2        |   CON4
>    egiga1         |     eth0        |   CON2
>    egiga2         |     eth1        |   CON3
>  -----------------+-----------------+--------------
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> 

Would it be possible to use entries in /aliases to fix the order of the
interfaces and make them match the physical ports?

	Arnd
