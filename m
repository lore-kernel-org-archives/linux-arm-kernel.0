From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 29 Jan 2016 08:27:08 +0100
Subject: [linux-sunxi] Problem with Allwinner H3 clocks
In-Reply-To: <20160128192931.GB32462@lukather>
References: <20160127084607.665fb8c38eeb5733ce4232da@free.fr>
 <CAGb2v65FUhNC-d-YT=-2adNHHT6b1JvGoNTFLfBX_xBSnuOsTg@mail.gmail.com>
 <20160127103714.58312b152adb4148bae2f93b@free.fr>
 <56A8D5E5.30701@gmail.com>
 <20160127175512.87caf31b5e21a1fec91507f2@free.fr>
 <56A9098A.5010107@redhat.com>
 <20160127200217.14dce96ade71cf81bc82e6f6@free.fr>
 <56A9CE3D.4020906@redhat.com> <56AA14AA.4070502@gmail.com>
 <20160128175918.78a916a8cd7bf4c0b2f2814f@free.fr>
 <20160128192931.GB32462@lukather>
Message-ID: <20160129082708.7f3b86e00b9ffa20ff29a1be@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Jan 2016 20:29:31 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> > You are right, I had these lines in my DT. Thanks.
> 
> And even though you had these lines, it was still not working? Or is
> it working now? I'm confused.

It was not working with these lines because I was using the real pll8,
and, so, Jens' old patch was needed.

> > The A23/A33/H3 (and surely some other SoCs) documentations about
> > the peripheral/periph/periph0/periph1 PLLs say:
> > 
> > 	Note: The PLL Output should be fixed to 600MHz, it is not
> > 	recommended to vary this value arbitrarily.
> 
> I don't know if it's worth it at this point. The pll6 seems to work
> fine at other rates. Have you experienced any breakage when running at
> another frequency?

Each times I started my machine, the clocks (periph0 and 1) were 600MHz.
I think that this value should be OK for all subdevices (with the
kernel 3.4, I have 200MHz for AHB1 and underneath, 600MHz for
deinterlace and CSI, 300MHz and 50MHz for MMC).

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
