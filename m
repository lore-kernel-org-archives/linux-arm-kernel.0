From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 20 Mar 2014 14:52:21 +0100
Subject: [PATCH] ASoC: tda998x: Fix lack of required reg in DT
 documentation
In-Reply-To: <532AEDE2.3080306@gmail.com>
References: <20140320092639.48F68A6279@smtp3-g21.free.fr>
 <532ADFD8.80301@gmail.com> <20140320140156.5d768b1f@armhf>
 <532AEDE2.3080306@gmail.com>
Message-ID: <20140320145221.09252bf6@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Mar 2014 14:32:18 +0100
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> Ok, I had another round of google'ing and found this:
> http://hipstercircuits.com/wp-content/uploads/2013/05/TDA19988.pdf
> 
> There, the datasheet specifically for TDA19988 only states 0x70 and
> 0x34 as the two i2c addresses. Therefore, TDA19988 has fixed i2c
> addresses while TDA9983b has configurable (main) i2c address.
> 
> Not as easy as we thought ;)
> 
> I suggest reword the reg property to:
> "- reg: shall be set to the I2C address"
> 
> and optionally list all known addresses for each TDA[1]998x in the
> binding.

Thanks for the link.

OK, then, as the linux tda998x driver handles only the tda 19988 and
19989 chips, the HDMI I2C address is always 0x70.

So, question: Russell and Sebastian, do you still want an other patch?

Other question: the CEC address is hard-coded to 0x34 in the driver.
Should it be configurable in the DT?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
