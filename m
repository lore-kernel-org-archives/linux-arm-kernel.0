From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Wed, 9 Nov 2016 13:54:53 +0000
Subject: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for
 special ISA
In-Reply-To: <2368890.jTbyGqYR0M@wuerfel>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478576829-112707-3-git-send-email-yuanzhichang@hisilicon.com>
 <20161108114953.GB15297@leverpostej> <2368890.jTbyGqYR0M@wuerfel>
Message-ID: <20161109135453.2e5402bd@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I think it is a relatively safe assumption that there is only one
> ISA bridge. A lot of old drivers hardcode PIO or memory addresses

It's not a safe assumption for x86 at least. There are a few systems with
multiple ISA busses particularly older laptops with a docking station.

> when talking to an ISA device, so having multiple instances is
> already problematic.

PCMCIA devices handle it themselves so are ok. I'm not clear how the dual
PIIX4 configuration used in the older IBM laptop docks actually worked so
I assume the transaction went out of both bridges and providing one of
them responded the other kept silent as you simply stuffed the card into
the dock and it worked.

Alan
