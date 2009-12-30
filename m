From: me@felipebalbi.com (Felipe Balbi)
Date: Wed, 30 Dec 2009 15:29:55 +0200
Subject: [patch-v2.6.34 7/9] usb: musb: use only clk framework for clk
	handling
In-Reply-To: <4B3B54E1.9010600@ru.mvista.com>
References: <1262127567-15202-1-git-send-email-felipe.balbi@nokia.com>
	<1262127567-15202-8-git-send-email-felipe.balbi@nokia.com>
	<4B3B3720.9070205@ru.mvista.com> <1262174012.28789.178.camel@gandalf>
	<4B3B504B.4020602@ru.mvista.com> <1262178881.17250.1.camel@gandalf>
	<4B3B54E1.9010600@ru.mvista.com>
Message-ID: <1262179795.17250.7.camel@gandalf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2009-12-30 at 16:25 +0300, Sergei Shtylyov wrote:
>    Gotcha. This will match in clk_find() by both device and clock name, 
> so clk_get() will fail with your patch.

then, when it doesn't find, it'll try device id only:

/*
 * Find the correct struct clk for the device and connection ID.
 * We do slightly fuzzy matching here:
 *  An entry with a NULL ID is assumed to be a wildcard.
 *  If an entry has a device ID, it must match
 *  If an entry has a connection ID, it must match
 * Then we take the most specific entry - with the following
 * order of precidence: dev+con > dev only > con only.
 */

and then we have found our clock :-)

-- 
balbi
