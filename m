From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 20 Mar 2014 14:01:56 +0100
Subject: [PATCH] ASoC: tda998x: Fix lack of required reg in DT
 documentation
In-Reply-To: <532ADFD8.80301@gmail.com>
References: <20140320092639.48F68A6279@smtp3-g21.free.fr>
 <532ADFD8.80301@gmail.com>
Message-ID: <20140320140156.5d768b1f@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Mar 2014 13:32:24 +0100
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> > +  - reg: I2C address - must be <0x70>  
> 
> TDA9983b datasheet says:
> 
> "Bits A0 and A1 of the I2C-bus device address are externally selected
> by pins A0 and A1."
> 
> Therefore, 0x70, 0x71, 0x72, and 0x73 are valid i2c addresses.

Sebastian,

That's interesting!

For the Cubox and the AMX33XX boards, the I2C address of the HDMI
registers is 0x70, and the I2C address of the CEC registers is 0x34.

For other boards using the TDA998x family, if the I2C address is
different from 0x70, have you an idea about what can be the CEC I2C
address? (this value is actually hard-coded in the TDA998x driver)

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
