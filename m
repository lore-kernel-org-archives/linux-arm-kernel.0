From: mbizon@freebox.fr (Maxime Bizon)
Date: Thu, 11 Oct 2012 13:47:35 +0200
Subject: alignment faults in 3.6
In-Reply-To: <1349954899.21172.8728.camel@edumazet-glaptop>
References: <20121005082439.GF4625@n2100.arm.linux.org.uk>
 <506ED18C.3010009@gmail.com> <20121005140556.GQ4625@n2100.arm.linux.org.uk>
 <506EEFBB.3060705@gmail.com> <507619FA.6080001@jonmasters.org>
 <yw1xtxu1pwtv.fsf@unicorn.mansr.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7038@saturn3.aculab.com>
 <yw1xpq4ppcju.fsf@unicorn.mansr.com>
 <1349949638.21172.8445.camel@edumazet-glaptop>
 <1349950926.21172.8521.camel@edumazet-glaptop>
 <20121011103257.GO4625@n2100.arm.linux.org.uk>
 <1349952574.21172.8604.camel@edumazet-glaptop>
 <1349952970.1232.5.camel@sakura.staff.proxad.net>
 <1349954899.21172.8728.camel@edumazet-glaptop>
Message-ID: <1349956055.1232.9.camel@sakura.staff.proxad.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, 2012-10-11 at 13:28 +0200, Eric Dumazet wrote:

> You probably are aware that a driver can use : 
> 
> - a fragment to hold the frame given by the hardware, with whatever
> alignment is needed by the hardware.
> 
> Then allocate an skb with enough room (128 bytes) to pull the headers as
> needed later.
> 
> skb = netdev_alloc_skb_ip_align(dev, 128);

What happen at tx time, supposing that same hardware cannot do SG ?

Aren't we going to memcpy the data into the head ?

-- 
Maxime
