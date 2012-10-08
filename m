From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 8 Oct 2012 21:57:06 +0200
Subject: [PATCH 5/6] ARM: dove: Remove watchdog from DT
In-Reply-To: <20121008184016.GA30416@jirafa.cyrius.com>
References: <1348531338-16624-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <201209251120.54255.arnd@arndb.de>
 <87haqmgw6n.fsf@lebrac.rtp-net.org>
 <201209251228.25752.arnd@arndb.de>
 <20121008184016.GA30416@jirafa.cyrius.com>
Message-ID: <20121008195706.GM21046@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin

> Arnaud Patard pointed out this conversation to me.  I added Orion and
> Kirkwood support to Debian. 

I used your guide at http://www.cyrius.com/debian/kirkwood/qnap/
to convert my QNAP-119P+ over to Debian. Works great.

> If someone volunteers to keep the Orion code up-to-date and/or port it
> to DT, I can perform tests from time to time.  I have the following
> Orion devices: QNAP TS-209, QNAP TS-409, HP mv2120 and D-Link DNS-323.

At the moment Kirkwood is my priority, but i think we should have most
of it converted to DT in the next three months. Once that is over, i
can look at Orion5x.

It is great you offered to test. I have a Marvell orion5x reference
system, rd88f5182. So i can do a lot of the conversion using
that. What i think will cause problems is PCI. There is scary looking
PCI code in the -setup.c files. I don't know how easy that will be to
convert to DT. However, it looks like most targets don't actually use
PCI, so maybe some will be easier to convert than others.

	Andrew
