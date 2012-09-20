From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 20 Sep 2012 21:51:06 +0200
Subject: [PATCH v4 03/10] pinctrl: mvebu: kirkwood pinctrl driver
In-Reply-To: <20120920213636.2ee27d41@skate>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <50559737.8000705@gmail.com>
 <CACRpkdY-Nyn73EJLvE1RsL4hgMRm6hALtnS-eKAXU7edot2V9A@mail.gmail.com>
 <201209201530.40974.arnd@arndb.de>
 <CACRpkdZYr2B83e3mBmMkO8Ai3xU_QGevfbSOSNoTvK3Lz6y6mg@mail.gmail.com>
 <20120920213636.2ee27d41@skate>
Message-ID: <20120920195106.GY28177@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> So, wouldn't we need a small, architecture-independent, infrastructure,
> through which architecture-specific code could "register" at boot
> time which SoC we are running on, and drivers could query this
> information from the common infrastructure?
> 
> Of course, the major problem is to figure out what is the good
> representation for this SoC identifier. Do we need a big list of SoCs
> like we had machine IDs? A simple string? Or maybe there is just no
> good way, and the whole idea is moot.

I did think about stuffing it inside the cpuinfo structures:

$ cat /proc/cpuinfo 
Processor       : Feroceon 88FR131 rev 1 (v5l)
BogoMIPS        : 1196.85
Features        : swp half thumb fastmult edsp 
CPU implementer : 0x56
CPU architecture: 5TE
CPU variant     : 0x2
CPU part        : 0x131
CPU revision    : 1

Hardware        : BUBBA3 Kirkwood based miniserver
Revision        : 0000
Serial          : 0000000000000000

I could imaging a 
SoC             : MV88F6281

It would probably need a bit of string parsing by any consumer, which
is not so good.

   Andrew
