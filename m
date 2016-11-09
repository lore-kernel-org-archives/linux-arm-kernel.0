From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Wed, 9 Nov 2016 14:51:01 +0000
Subject: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for
 special ISA
In-Reply-To: <20161109135453.2e5402bd@lxorguk.ukuu.org.uk>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478576829-112707-3-git-send-email-yuanzhichang@hisilicon.com>
 <20161108114953.GB15297@leverpostej>	<2368890.jTbyGqYR0M@wuerfel>
 <20161109135453.2e5402bd@lxorguk.ukuu.org.uk>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F8F229A@lhreml507-mbx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: One Thousand Gnomes [mailto:gnomes at lxorguk.ukuu.org.uk]
> Sent: 09 November 2016 13:55
> To: Arnd Bergmann
> Cc: Mark Rutland; Yuanzhichang; catalin.marinas at arm.com;
> will.deacon at arm.com; robh+dt at kernel.org; bhelgaas at google.com;
> olof at lixom.net; linux-arm-kernel at lists.infradead.org;
> lorenzo.pieralisi at arm.com; linux-kernel at vger.kernel.org; Linuxarm;
> devicetree at vger.kernel.org; linux-pci at vger.kernel.org; linux-
> serial at vger.kernel.org; minyard at acm.org; benh at kernel.crashing.org;
> liviu.dudau at arm.com; zourongrong at gmail.com; John Garry; Gabriele
> Paoloni; zhichang.yuan02 at gmail.com; kantyzc at 163.com; xuwei (O);
> marc.zyngier at arm.com
> Subject: Re: [PATCH V5 2/3] ARM64 LPC: Add missing range exception for
> special ISA
> 
> > I think it is a relatively safe assumption that there is only one
> > ISA bridge. A lot of old drivers hardcode PIO or memory addresses
> 
> It's not a safe assumption for x86 at least. There are a few systems
> with
> multiple ISA busses particularly older laptops with a docking station.

Mmmm right...now the point is that this kind of special devices appearing
as a special ISA bus will probably never appear on x86 platforms (I guess).

So maybe it is a safe assumption because of this...?

Thanks

Gab

> 
> > when talking to an ISA device, so having multiple instances is
> > already problematic.
> 
> PCMCIA devices handle it themselves so are ok. I'm not clear how the
> dual
> PIIX4 configuration used in the older IBM laptop docks actually worked
> so
> I assume the transaction went out of both bridges and providing one of
> them responded the other kept silent as you simply stuffed the card
> into
> the dock and it worked.
> 
> Alan
