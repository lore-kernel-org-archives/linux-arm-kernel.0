From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 Feb 2013 23:27:52 +0000
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <CAPcvp5EC=e8TbX9s88hF9uKMzTc6655k9=mgdEc0szP_phhbXQ@mail.gmail.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130207183743.5c97d8b8@skate>
 <CAPcvp5EC=e8TbX9s88hF9uKMzTc6655k9=mgdEc0szP_phhbXQ@mail.gmail.com>
Message-ID: <201302072327.52328.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 February 2013, Andrew Murray wrote:
> I'm not sure if the device pin part of the map is correct (I always
> forget how this works) - but I know this would definately work:
> 
>                          interrupt-map-mask = <0xf800 0 0 7>
>                          interrupt-map = <0x0800 0 0 1 &mpic 58
>                                           0x0800 0 0 2 &mpic 58
>                                           0x0800 0 0 3 &mpic 58
>                                           0x0800 0 0 4 &mpic 58
>                                           0x1000 0 0 1 &mpic 59
>                                           0x1000 0 0 2 &mpic 59
>                                           0x1000 0 0 3 &mpic 59
>                                           0x1000 0 0 4 &mpic 59
>                                           ....

If all the pins are routed to the same interrupt, you can leave
the pin out of the map-mask and save a bunch of lines in the
interrupt-map, at least  by the spec. I have not looked at the
source code to see if that is how Linux implements the lookup,
but that can be fixed if necessary.

	Arnd
