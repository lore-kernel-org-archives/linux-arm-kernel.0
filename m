From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 11 May 2011 23:56:52 +0100
Subject: [PATCH v4 1/1] can: add pruss CAN driver.
In-Reply-To: <4DCB103B.30801@pengutronix.de>
References: <1303474267-6344-1-git-send-email-subhasish@mistralsolutions.com>
	<2BFFDAA0A0DE4820876E5549867938EC@subhasishg>
	<201105112331.47954.arnd@arndb.de>
	<201105112344.44171.arnd@arndb.de> <4DCB103B.30801@pengutronix.de>
Message-ID: <20110511235652.7ccddb3b@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I'm not sure if reprogramming hardware filters on the fly works on evey
> can core. The more conservative solution would be to configure the
> filter list globally (+when the interface is down) via netlink.

For anything that isn't so braindead it ought to be done on the fly and
behind the users back to avoid having to make app code specially aware.
If the lists are fixed either in firmware or in software the stack needs
to error attempts to use anything else - and as you say you need some
kind of way to configure those global lists, preferably portably.

Alan
