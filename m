From: moinejf@free.fr (Jean-Francois Moine)
Date: Sun, 19 May 2013 18:49:05 +0200
Subject: [RFC 4/4] DRM: tda998x: add missing include
In-Reply-To: <51988D88.10306@gmail.com>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
 <1368897139-25485-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1368897139-25485-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130518194644.2a02a4fc@armhf>
 <CAF6AEGtx7RbvKEEc5uSFvz-2uveB1cnJNf_ESn6JYhfte5UmZQ@mail.gmail.com>
 <20130518205845.2dfe9fe5@armhf> <5197D6C1.3060702@gmail.com>
 <20130519080152.0b486b75@armhf> <51988D88.10306@gmail.com>
Message-ID: <20130519184905.1f238710@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 19 May 2013 10:30:00 +0200
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:
> > /* --- test (not cubox) ---- *
> > &dcon { status = "okay"; };
> > 
> > &lcd1 {
> > 	status = "okay";
> > 	clocks =<&core_clk 3>,<0>,<&lcdclk>,<0>;
> > 	marvell,port-type =<1>;
> > 	display-timings {
> > 		mode {
> > 			hactive =<1920>;
> > 			vactive =<1080>;
> > 			hfront-porch =<88>;
> > 			hsync-len =<44>;
> > 			hback-porch =<148>;
> > 			vfront-porch =<4>;
> > 			vsync-len =<5>;
> > 			vback-porch =<36>;
> > 			clock =<148500>;
> > 		};
> > 	};  
> 
> I would be surprised if, lcd1 will ever be capable of driving
> 1080p60 on a *VGA port*!

As you may see, this sequence is preceded by an open comment: "test".

Now, as the port B of the display controller is only VGA (this is
checked in my driver), as there is no VGA connector on the Cubox, as
there is no VGA DAC code in my driver, and as I had to test the display
controller, I:

- defined the port B as VGA,

- set the timings of the mode I use for my HDMI display.

This does not mean the example must be used in the real word. It is
just a working example for test purpose.

> Seriously, start _reading_ what we say. I want all those
> features I already told you for your driver, in mainline driver
> too. All I told you was to prevent you from doing dirty little
> Cubox specific hacks that I would have to remove for e.g. D2Plug.

There is _NO_ Cubox specific stuff in my driver (I don't even use any
cubox-setup as Russell) and it should work without any change (except
the DT) in your D2plug. Remember, all my drm driver work is in
http://moinejf.free.fr/cubox/ as a big kernel patch (I will add the
I2C: mv64xxx which work fine - thanks Russell).

> *But* if you ask me if we should take Russell's or your driver
> as a basis, the answer is Russell's. Colon.

OK. Do what you want. My driver works fine enough for my usage:
software development. For video, my ISP gives us for free a Atom based
multimedia player with a Blue-Ray reader, and I have a AMD64 double
core on my family TV set for internet video (it will be a long time
till there will be VP8 decoding with vMeta). The only interest I see
in the Cubox is its low power consumption.

Now, I will switch back to my favorite long-distance development...

See you.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
