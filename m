From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 22 Sep 2014 19:13:27 +0200
Subject: [PATCH] i2c-rk3x: move setup to the earlier subsys initcall
In-Reply-To: <CAD=FV=VUoK8SDng6O4-VVq8UZf88b3bSe-hQMht3R2nmYXqMFQ@mail.gmail.com>
References: <1411370675-27866-1-git-send-email-zyw@rock-chips.com>
 <7192455.FveG5nGWsJ@xq-nb>
 <CAD=FV=VUoK8SDng6O4-VVq8UZf88b3bSe-hQMht3R2nmYXqMFQ@mail.gmail.com>
Message-ID: <20140922171325.GB1404@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> In general you are correct.  You can get by with lots of probe
> deferrals.  I don't personally know of any case where things are
> broken with the current code, but it's really nice to avoid the
> deferrals if possible.

Yes, we all want proper dependencies and ordering, yet deferred probing
is the best we have.

> Given that this is a core SoC i2c bus and is used for _a lot_ of
> external connectivity (including for connecting to the primary
> regulator on most boards), bumping up the priority in the init order
> makes a lot of sense to me.
> 
> This also matches the i2c busses of most other major SoCs.  A selected
> few examples:
> 
> i2c-gpio.c:subsys_initcall(i2c_gpio_init);
> i2c-omap.c:subsys_initcall(omap_i2c_init_driver);
> i2c-s3c2410.c:subsys_initcall(i2c_adap_s3c_init);
> i2c-tegra.c:subsys_initcall(tegra_i2c_init_driver);

They were "lucky" to be around before deferred probing and using
subsys_initcall was always considered a hack. I am not accepting new
users of this hack unless there is really no other solution.

So, NACK, since it doesn't solve a problem.

Regards,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140922/4c05c670/attachment.sig>
