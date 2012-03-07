From: robertcnelson@gmail.com (Robert Nelson)
Date: Tue, 6 Mar 2012 18:39:34 -0600
Subject: [PATCH] omap3_beagle: init uart2 for beagle rev AX/BX only
In-Reply-To: <20120306213859.GA12083@atomide.com>
References: <1331024711-23578-1-git-send-email-govindraj.raja@ti.com>
 <20120306213859.GA12083@atomide.com>
Message-ID: <CAOCHtYiERN2VySbBb7BoJAa97P4z6=a094vUMmgej3JP5Cy25g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 6, 2012 at 3:38 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Govindraj.R <govindraj.raja@ti.com> [120306 00:34]:
>> From: "Govindraj.R" <govindraj.raja@ti.com>
>>
>> All beagle boards rev > AX/BX have external usb hubs connected to ehci
>> interface, external hub/peripheral uses a nreset sequence for which
>> uart2_rx.gpio_147 pin in mux mode4(USB2HS_nRST) is used on all beagle
>> boards expect rev Ax/BX.
>> (Reference to all beagle boards rev schematics:
>> http://beagleboard.org/hardware/design)
>>
>> Initialising uart2 will lead to serial init taking over uart2_rx pin
>> so init uart2_rx pin mux only for Beagle AX/BX rev boards.
>> Dont init uart2 for all other boards allowing usb_ehci functionality.
>>
>> To initialise individual uart port by id utilise and modify the existing
>> available func. omap_serial_board_init.
>>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>> Cc: Koen Kooi <koen@dominion.thruhere.net>
>> Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> Tested-by: Robert Nelson <robertcnelson@gmail.com>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>
> Can somebody please test this on non-xm beagle too and
> reply with a Tested-by?

Here's an update for my: Tested-by: Robert Nelson <robertcnelson@gmail.com>

Just tested with one of my Beagle C4's, (and re-verified the new patch
on a xM B) using usb flash drives on the ehci port...

beagle c4:
v3.2.9
Bus 001 Device 002: ID 0457:0151 Silicon Integrated Systems Corp.
Super Flash 1GB / GXT  64MB Flash Drive

v3.3-rc6:
ehci broken

v3.3-rc6 + this patch:
Bus 001 Device 002: ID 0457:0151 Silicon Integrated Systems Corp.
Super Flash 1GB / GXT  64MB Flash Driv

beagle xM B:
v3.2.9
Bus 001 Device 004: ID 1977:0824 T-Logic

v3.3-rc6:
ehci broken

v3.3-rc6 + this patch:
Bus 001 Device 004: ID 1977:0824 T-Logic

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
