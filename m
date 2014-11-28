From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 17:49:14 +0100
Subject: [PATCH 2/2] ARM: imx: src: support vf610 system reset controller
In-Reply-To: <1417193015-6033-3-git-send-email-stefan@agner.ch>
References: <1417193015-6033-1-git-send-email-stefan@agner.ch>
 <1417193015-6033-3-git-send-email-stefan@agner.ch>
Message-ID: <34359137.rt8QrS7shW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 November 2014 17:43:35 Stefan Agner wrote:
> Support Vybrid SoC's system reset controller (SRC). Currently we
> don't register a reset controller but only support the imx_cpu_jump
> and imx_cpu_arg functions.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

I think this should be a platform driver in drivers/power/reset.

If the SRC is also capable of resetting individual blocks instead of just
the entire machine, it would be a reset driver in drivers/reset instead.

	Arnd
