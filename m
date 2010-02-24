From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 24 Feb 2010 09:42:59 +0100
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <1266933437-4876-1-git-send-email-hector@marcansoft.com>
References: <1266933437-4876-1-git-send-email-hector@marcansoft.com>
Message-ID: <20100224084259.GA8068@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

[expanded Cc:]

On Tue, Feb 23, 2010 at 02:57:17PM +0100, hector at marcansoft.com wrote:
> From: Hector Martin <hector@marcansoft.com>
> 
> The -Dstatic= stuff in the Makefile is a hack and subtly breaks the
> current inflate implementation, because the fixed inflate tables are
> included into a function and removing static places them in the stack,
Maybe this is the problem that people see after e7db7b4270?  Is this the
final hint that we should revert that one?

> which bloats the stack and breaks references after the function returns.
> So get rid of the hack.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
