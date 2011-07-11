From: utx@penguin.cz (Stanislav Brabec)
Date: Mon, 11 Jul 2011 22:56:31 +0200
Subject: [Zaurus-devel] [PATCH v2] MAX1111: Fix Race condition causing
	NULL pointer exception
In-Reply-To: <1310410051-13127-1-git-send-email-morpheus.ibis@gmail.com>
References: <1310410051-13127-1-git-send-email-morpheus.ibis@gmail.com>
Message-ID: <1310417791.17423.3.camel@utx.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pavel Herrmann wrote:
> spi_sync call uses its spi_message parameter to keep completion information,
> having this structure static is not thread-safe, potentially causing one
> thread having pointers to memory on or above other threads stack. use mutex
> to prevent multiple access
> 
> Signed-off-by: Pavel Herrmann <morpheus.ibis@gmail.com>
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Marek Vasut <marek.vasut@gmail.com>
> Acked-by: Cyril Hrubis <metan@ucw.cz>
Tested-by: Stanislav Brabec <utx@penguin.cz>

Tested on spitz, fixed previously reproducible OOPSes and kernel panic.

(See thread "kernel panic in spi_complete() on spitz (PXA270)" in
linux-arm-kernel at lists.infradead.org.)

-- 

________________________________________________________________________
Stanislav Brabec
http://www.penguin.cz/~utx/zaurus
