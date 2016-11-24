From: ada@thorsis.com (Alexander Dahl)
Date: Thu, 24 Nov 2016 10:29:27 +0100
Subject: reboot fails on at91sam9g20 with kernel 4.x
In-Reply-To: <20161123221121.pkkhwhgqig5elwa7@piout.net>
References: <2093786.uQmBVvCouf@ada>
 <20161123221121.pkkhwhgqig5elwa7@piout.net>
Message-ID: <2142335.mtG1e6fW2s@ada>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hei hei,

Am Mittwoch, 23. November 2016, 23:11:21 schrieb Alexandre Belloni:
> Since 3.18, the shdwc and reset controller have their own drivers that
> may or may not be compiled in the kernel. Can you check you have
> CONFIG_POWER_RESET_AT91_POWEROFF and CONFIG_POWER_RESET_AT91_RESET
> set in your configuration? Also, you probably want to check the DT
> definition of the shdwc and the rstc.

You were right, those were not set.

-# CONFIG_POWER_RESET is not set
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_AT91_POWEROFF=y
+CONFIG_POWER_RESET_AT91_RESET=y

With the above change in the kernel config the board reboots fine.

I'm not quite sure anymore how I got to my kernelconfig, maybe based on 
a pre 3.18 config without going through oldconfig. 

I double checked the at91_dt_defconfig from 4.8.10 now and it activates 
those options, maybe I should have done this in the first place.

So thank you very much for your hint. :-)

Greets
Alex

-- 
------------------------------------------------------------------------
Thorsis Technologies GmbH                     Tel.: +49-391-544 563-3036
Oststra?e 18                                  Fax.: +49-391-544 563-9099
39114 Magdeburg                                  http://www.thorsis.com/

Sitz der Gesellschaft: Magdeburg
Amtsgericht Stendal HRB 110339
Gesch?ftsf?hrer: Dipl.-Ing. Thorsten Szczepanski
------------------------------------------------------------------------
