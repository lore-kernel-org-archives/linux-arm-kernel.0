From: martinwguy@gmail.com (Martin Guy)
Date: Sat, 17 Apr 2010 04:23:53 +0100
Subject: ep93xx SPI driver v3
In-Reply-To: <20100416171032.GD6718@gw.healthdatacare.com>
References: <20100415173905.GJ2685@gw.healthdatacare.com>
	<j2u56d259a01004151645y47ec8254ree59189aaa6b5baa@mail.gmail.com>
	<20100416042658.GK2685@gw.healthdatacare.com>
	<l2p56d259a01004160211m17bc0f10gc63a5ca82436c8e3@mail.gmail.com>
	<20100416094444.GC6718@gw.healthdatacare.com>
	<p2l56d259a01004160455jdf290557yd102cf78d9f1252e@mail.gmail.com>
	<20100416171032.GD6718@gw.healthdatacare.com>
Message-ID: <r2j56d259a01004162023tdf8f226aw5aab98bd54c03ac0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cc-ing to list...

> Next thing (after possible bug fixes, that is) is probably to
> implement proper DMA support. Unfortunately there is no platform
> code for that yet, only M2P controller support :( which means that
>  we have to implement M2M controller support

Yes, ep93xx DMA engine has two flavours: memory-to-peripheral, used
for most devices, and memory-to-memory, used for block memcpy and for
memory-to-SSP/SPI (== SD card).

The easiest route would seem to be to get the M2M stuff working to do
memcpy fast. Can linux make use of that? I haven't yet seen anything
that can make use of a memory-to-memory copy DMA engine.

If we can get that working, a reasonable second stage would make it
work for ep93xx-SPI transfers, making SD card access even less
CPU-intensive

   M
