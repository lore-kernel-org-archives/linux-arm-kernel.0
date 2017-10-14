From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 14 Oct 2017 16:52:29 +0200
Subject: [PATCH 0/3] Enable CEC on rk3399
In-Reply-To: <CAJ-oXjQ3e1UHVGq=uV=yAK9Bu=ZoiNZaEbnHyvNtyc15RQQSKg@mail.gmail.com>
References: <20171013225337.5196-1-phh@phh.me>
 <9833f103-769f-b9b9-05c7-4d75bd7e487c@xs4all.nl>
 <CAJ-oXjQ3e1UHVGq=uV=yAK9Bu=ZoiNZaEbnHyvNtyc15RQQSKg@mail.gmail.com>
Message-ID: <2009704.s5LEIeT6xV@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 14. Oktober 2017, 15:14:40 CEST schrieb Pierre-Hugues Husson:
> Hi Hans,
> 
> > Nice! I had a similar dw-hdmi.c patch pending but got around to posting it.
> >
> > I'll brush off my old rk3288 patches and see if I can get CEC enabled
> > for my firefly-reload. I was close to getting it work, but I guess
> > missed the "enable cec pin" change.
> Please note that on rk3288, there are two CEC pins, and you must write
> in RK3288_GRF_SOC_CON8 which pin you're using.
> On the firefly-reload, the pin used is GPIO7C0, while the default pin
> configuration is GPIO7C7.

And as an additional note, later socs have even more of these pin-routing
settings and we currently have infrastructure in the pinctrl driver to do
this automatically depending on the pinctrl settings.

So most likely this can also be added there for the rk3288.


Heiko
