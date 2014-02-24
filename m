From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Feb 2014 19:12:01 +0100
Subject: [PATCH] ARM: Kirkwood: Remove redundant kexec code
In-Reply-To: <1393265364-29241-1-git-send-email-andrew@lunn.ch>
References: <1393265364-29241-1-git-send-email-andrew@lunn.ch>
Message-ID: <1778543.yhKrLGS8zF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 February 2014 19:09:24 Andrew Lunn wrote:
> The PCIe driver has been fully clock aware for quite a while.  Remove
> the kexec code to enable the PCIe clock, since the PCIe driver will do
> the right thing.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Acked-by: Arnd Bergmann <arnd@arndb.de>

It's probably worth mentioning in the changelog that this fixes a
build error for the case when CONFIG_KEXEC is enabled but
KIRKWOOD_LEGACY is not.

	Arnd
