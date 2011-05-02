From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 2 May 2011 23:36:52 +0200
Subject: [RFC PATCH 4/4] ARM: Xilinx: Adding Xilinx board support
In-Reply-To: <538266033.2230575.1304371624720.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
References: <538266033.2230575.1304371624720.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
Message-ID: <201105022336.52663.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 May 2011 23:27:04 johnlinn at comcast.net wrote:
> Yes we could explain hard coded numbers.  Ideally GIC driver would support
> device tree it seems like to me.

> 
> Seems like the GIC driver could remap it's own memory but maybe that won't
> work across all platforms and then the platform would need to do it.

Why not just add a stub in the xilinx platform for now that remaps the
memory using ioremap and calls the regular GIC initialization?

That function can then easily be moved to common code when another
platform uses it.

	Arnd
