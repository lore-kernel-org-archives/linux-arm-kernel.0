From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Dec 2013 13:34:12 +0000
Subject: [PATCH] net: mvmdio: fix wait_event_timeout() being called
 with a 1 jiffy timeout.
In-Reply-To: <1386076560-1886-1-git-send-email-nschichan@freebox.fr>
References: <20131203122346.GD29282@titan.lakedaemon.net>
 <1386076560-1886-1-git-send-email-nschichan@freebox.fr>
Message-ID: <20131203133412.GU16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 02:16:00PM +0100, Nicolas Schichan wrote:
> If a timer interrupt kicks right after the wait_event_timeout() call,
> we may endup a reporting timeout before the timeout really occured.

Please see my reply to Jason Cooper about this in the thread
"Spurious timeouts in mvmdio".
