From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 02 Sep 2016 19:58:04 +0200
Subject: [PATCH] pcmcia: sa1111: fix propagation of lowlevel board init
 return code
In-Reply-To: <E1bfnCj-0006HT-12@rmk-PC.armlinux.org.uk> (Russell King's
 message of "Fri, 02 Sep 2016 13:04:17 +0100")
References: <E1bfnCj-0006HT-12@rmk-PC.armlinux.org.uk>
Message-ID: <87eg52kwur.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King <rmk+kernel@armlinux.org.uk> writes:

> When testing Lubbock, it was noticed that the sa1111 pcmcia driver bound
> but was not functional due to no sockets being registered.  This is
> because the return code from the lowlevel board initialisation was not
> being propagated out of the probe function.  Fix this.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
> Robert,
>
> I'd prefer this solution.  Please check that it resolves your issue,
> thanks.

Excellent, tested it without the clock fix on lubbock, and the error message is
there.

Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
