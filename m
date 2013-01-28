From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 28 Jan 2013 10:17:33 -0500 (EST)
Subject: [PATCH 09/30] USB: ehci-omap: Use devm_request_and_ioremap()
In-Reply-To: <1359372631-8180-10-git-send-email-rogerq@ti.com>
Message-ID: <Pine.LNX.4.44L0.1301281013010.1997-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Jan 2013, Roger Quadros wrote:

> Make use of devm_request_and_ioremap() and correct comment.

Didn't a big patch come through recently converting all usages of 
devm_request_and_ioremap() to another function (I forget the name) that 
does its own error reporting and returns an ERR_PTR value?

(Checks the mailing list archive...)  Ah, here it is:

	http://marc.info/?l=linux-usb&m=135876311801537&w=2

And the new function is devm_ioremap_resource().  We should avoid 
adding new usages of an old interface.

Alan Stern
