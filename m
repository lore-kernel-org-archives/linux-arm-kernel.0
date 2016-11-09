From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 09 Nov 2016 22:38:32 +0100
Subject: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for special
 ISA
In-Reply-To: <20161109135453.2e5402bd@lxorguk.ukuu.org.uk>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <2368890.jTbyGqYR0M@wuerfel> <20161109135453.2e5402bd@lxorguk.ukuu.org.uk>
Message-ID: <5900275.i4NZvtxTcC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 9, 2016 1:54:53 PM CET One Thousand Gnomes wrote:
> > I think it is a relatively safe assumption that there is only one
> > ISA bridge. A lot of old drivers hardcode PIO or memory addresses
> 
> It's not a safe assumption for x86 at least. There are a few systems with
> multiple ISA busses particularly older laptops with a docking station.

But do they have multiple ISA domains? There is no real harm in supporting
it, the (small) downsides I can think of are:

- a few extra cycles for the lookup, from possibly walking a linked list
  to find the correct set of helpers and MMIO addresses
- making it too general could invite more people to design hardware
  around the infrastructure when we really want them to stop adding
  stuff like this.

	Arnd
