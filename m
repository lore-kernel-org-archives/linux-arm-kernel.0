From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 9 May 2011 16:08:10 +0200
Subject: [PATCH 04/14] [orion] Consolidate ethernet platform data
In-Reply-To: <BANLkTim4uDH54+zj7XAxHi24a0X_-r2BSQ@mail.gmail.com>
References: <1304864141-1121-1-git-send-email-andrew@lunn.ch>
	<1304864141-1121-5-git-send-email-andrew@lunn.ch>
	<BANLkTim4uDH54+zj7XAxHi24a0X_-r2BSQ@mail.gmail.com>
Message-ID: <20110509140810.GA31070@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 08, 2011 at 06:29:54PM +0300, saeed bishara wrote:
> On Sun, May 8, 2011 at 5:15 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> > -static struct resource dove_ge00_shared_resources[] = {
> > - ?? ?? ?? {
> > - ?? ?? ?? ?? ?? ?? ?? .name ?? = "ge00 base",
> > - ?? ?? ?? ?? ?? ?? ?? .start ??= DOVE_GE00_PHYS_BASE + 0x2000,
> > - ?? ?? ?? ?? ?? ?? ?? .end ?? ??= DOVE_GE00_PHYS_BASE + SZ_16K - 1,

> I looked at the KW/Dove/mv87xx specs, the giga port doesn't use more
> than 4K address space. so you can assume drop the size parameter from
> the orion_gexx_init functions.

I'm not sure this is true. I have the document
FS_88F6180_9x_6281_OpenSource.pdf which describes the
88F6180/88F619x/88F6281. It states that:

Destination Address Filter Unicast Table (DFUT) Register (n=0-3)
Port0: Register0: 0x73600, Register1: 0x73604, Register2: 0x73608, Register3: 0x7360C

0x7360c is about 5.5K after GE00_PHYS_BASE.

I think 16K address space is correct.

  Andrew
