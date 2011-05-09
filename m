From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 9 May 2011 22:36:12 +0200
Subject: [PATCH] pxamci: remove an ifdef about CONFIG_REGULATOR
In-Reply-To: <20110509202325.GD16919@n2100.arm.linux.org.uk>
References: <1304971869-20161-1-git-send-email-ospite@studenti.unina.it>
	<20110509202325.GD16919@n2100.arm.linux.org.uk>
Message-ID: <20110509203612.GC21323@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 09, 2011 at 09:23:25PM +0100, Russell King - ARM Linux wrote:

> NAK.  This has been proposed before, and rejected.  See the comments
> against the original proposal:

> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6525/1

Hrm, this looks like the bodge we're doing for !REGULATOR isn't actually
helping here unless we do a NULL || IS_ERR() in the error check.  The
ifdefs are certainly fail.
