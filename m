From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 21 Jan 2016 08:05:24 +0100
Subject: [PATCH 1/2] regulator: ltc3589: make IRQ optional
In-Reply-To: <20160120164258.GF6588@sirena.org.uk>
References: <1453292992-1788-1-git-send-email-LW@KARO-electronics.de>
 <1453292992-1788-2-git-send-email-LW@KARO-electronics.de>
 <20160120164258.GF6588@sirena.org.uk>
Message-ID: <20160121080524.27af489f@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> On Wed, Jan 20, 2016 at 01:29:51PM +0100, Lothar Wa?mann wrote:
> 
> > This pin is used as IRQ pin for the LTC3589 PMIC on the Ka-Ro
> > electronics TX48 module. Make the IRQ optional in the driver and use a
> > polling routine instead if no IRQ is specified in DT.
> > Otherwise the driver will continuously generate interrupts and make
> > the system unusable.
> 
> How will the driver generate interrupts if there is no interrupt
> physically present in the system?
>
It's using timer interrupts to poll the LTC3589 state.


Lothar Wa?mann
