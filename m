From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 May 2011 21:23:25 +0100
Subject: [PATCH] pxamci: remove an ifdef about CONFIG_REGULATOR
In-Reply-To: <1304971869-20161-1-git-send-email-ospite@studenti.unina.it>
References: <1304971869-20161-1-git-send-email-ospite@studenti.unina.it>
Message-ID: <20110509202325.GD16919@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 09, 2011 at 10:11:09PM +0200, Antonio Ospite wrote:
> Don't wrap regulator_get() inside an #ifdef CONFIG_REGULATOR anymore, as
> now (since be1a50d) it correctly degenerates and returns NULL when the
> regulator framework is disabled.
> 
> Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>

NAK.  This has been proposed before, and rejected.  See the comments
against the original proposal:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6525/1
