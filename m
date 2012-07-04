From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Wed, 4 Jul 2012 12:45:03 +0000
Subject: How to handle parameter variation across different boards but same
 platform
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EA3532A@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

Currently on Davinci platform, codec system clock & snd_soc_card parameter is decided
using machine_is_xxxx() api.

	sound/soc/Davinci/davinci-evm.c, inside evm_hw_params() & evm_init(),

We have an upcoming board based on TI AM335x soc which has both codec system clock 
And the codec name (because of i2c bus difference) different from previous am335x 
based boards. 

Using machine_is_xxx() is not sufficient because there are 2 other boards on same 
Platform/machine but with different values.

So, how to specify these parameters for the new board?

Regards
Gururaja
