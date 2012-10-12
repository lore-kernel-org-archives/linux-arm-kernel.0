From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 12 Oct 2012 17:21:57 +0900
Subject: [PATCH] i2c: change the id to let the i2c device work
In-Reply-To: <20121012100521.64cb9adb@endymion.delvare>
References: <1350009258-10044-1-git-send-email-voice.shen@atmel.com>
 <20121012044042.GI11726@opensource.wolfsonmicro.com>
 <5077A33E.4080801@atmel.com>
 <20121012051419.GJ11726@opensource.wolfsonmicro.com>
 <5077AE8C.5040605@atmel.com>
 <20121012055301.GM11726@opensource.wolfsonmicro.com>
 <20121012091427.0d7b2bed@endymion.delvare>
 <5077CCF4.7070104@atmel.com>
 <20121012100521.64cb9adb@endymion.delvare>
Message-ID: <20121012082155.GP11726@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2012 at 10:05:21AM +0200, Jean Delvare wrote:

> Ah sorry I misread Mark's request. i2c-gpio will turn the platform
> device ID into bus number, it can indeed not be forced through platform
> data. But I don't think any other i2c bus driver allows this either. I
> don't quite see the problem with setting a platform device ID even if
> there's only one instance of the platform device. I have many examples
> of this on my machine:
> Fixed MDIO bus.0
> coretemp.0
> vesafb.0

This is generally bad style; if it's required by APIs we really should
be fixing the APIs to remove this sort of dependency.  Aside from the
ugliness it tends to be fragile.

> So please just set the platform device ID to 0 (or whatever i2c adapter
> number you want) and your problem is solved. As you just proposed
> initially, actually :)

Though it *does* need a comprehensible commit message so people can
understand what on earth the change is intended to do.
