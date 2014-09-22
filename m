From: max.schwarz@online.de (Max Schwarz)
Date: Mon, 22 Sep 2014 18:20:20 +0200
Subject: [PATCH] i2c-rk3x: move setup to the earlier subsys initcall
In-Reply-To: <7192455.FveG5nGWsJ@xq-nb>
References: <1411370675-27866-1-git-send-email-zyw@rock-chips.com>
 <7192455.FveG5nGWsJ@xq-nb>
Message-ID: <2856441.ivW6yi69vh@xq-nb>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

> > +subsys_initcall(rk3x_i2c_init_driver);
> > +module_exit(rk3x_i2c_exit_driver);
> 
> This means that the driver cannot be used as a loadable module any more,
> right?
> 
> In that case, you should probably turn the tristate option in Kconfig into a
> bool.

I'm sorry, I see now that subsys_initcall() gets mapped to module_init() if 
the driver is built as a loadable module. Everything is fine ;-)

Acked-By: Max Schwarz <max.schwarz@online.de>

Cheers,
  Max
