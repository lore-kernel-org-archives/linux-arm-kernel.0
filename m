From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 20 Mar 2014 14:25:08 +0100
Subject: [PATCH] ASoC: tda998x: Fix lack of required reg in DT
 documentation
In-Reply-To: <20140320140156.5d768b1f@armhf>
References: <20140320092639.48F68A6279@smtp3-g21.free.fr>
 <532ADFD8.80301@gmail.com> <20140320140156.5d768b1f@armhf>
Message-ID: <20140320142508.557fb860@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Mar 2014 14:01:56 +0100
Jean-Francois Moine <moinejf@free.fr> wrote:

> For other boards using the TDA998x family, if the I2C address is
> different from 0x70, have you an idea about what can be the CEC I2C
> address? (this value is actually hard-coded in the TDA998x driver)

I had a look again on the tda998x driver from NXP and the linux tda998x
driver:

- the NXP driver handles the TDAs 19989, 19988, 9984, 9983 and 9981.
  It accesses the tda registers only at I2C address 0x70 and 0x34
  (hard-coded values in the driver).

- the linux tda998x driver handles only the TDAs 19988 and 19989.

As we have no documentation about the chips TDA 19988 and 19989,
may the HDMI I2C addresses of these chips be different from 0x70?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
