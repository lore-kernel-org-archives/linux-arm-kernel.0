From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 28 Jan 2016 20:29:31 +0100
Subject: [linux-sunxi] Problem with Allwinner H3 clocks
In-Reply-To: <20160128175918.78a916a8cd7bf4c0b2f2814f@free.fr>
References: <20160127084607.665fb8c38eeb5733ce4232da@free.fr>
 <CAGb2v65FUhNC-d-YT=-2adNHHT6b1JvGoNTFLfBX_xBSnuOsTg@mail.gmail.com>
 <20160127103714.58312b152adb4148bae2f93b@free.fr>
 <56A8D5E5.30701@gmail.com>
 <20160127175512.87caf31b5e21a1fec91507f2@free.fr>
 <56A9098A.5010107@redhat.com>
 <20160127200217.14dce96ade71cf81bc82e6f6@free.fr>
 <56A9CE3D.4020906@redhat.com> <56AA14AA.4070502@gmail.com>
 <20160128175918.78a916a8cd7bf4c0b2f2814f@free.fr>
Message-ID: <20160128192931.GB32462@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 05:59:18PM +0100, Jean-Francois Moine wrote:
> On Thu, 28 Jan 2016 14:16:26 +0100
> Jens Kuske <jenskuske@gmail.com> wrote:
> 
> > after figuring out how to boot a devicetree kernel with allwinner's
> > u-boot I only had to add the mandatory
> > 	
> > 	clock-frequency = <24000000>;
> > 	arm,cpu-registers-not-fw-configured;
> > 
> > to the timer node and v4.5-rc1 booted successfully. They are
> > intentionally left out in the official dt, because documentation says
> > one should prefer to fix the firmware -> mainline u-boot
> > No problems with clocks or uart here.
> 
> You are right, I had these lines in my DT. Thanks.

And even though you had these lines, it was still not working? Or is
it working now? I'm confused.

> But, now, what about the PLL8 (periph1) which should be used by the MMCs?

I just sent another version of the pll6 rework to enable it.

> The A23/A33/H3 (and surely some other SoCs) documentations about
> the peripheral/periph/periph0/periph1 PLLs say:
> 
> 	Note: The PLL Output should be fixed to 600MHz, it is not
> 	recommended to vary this value arbitrarily.

I don't know if it's worth it at this point. The pll6 seems to work
fine at other rates. Have you experienced any breakage when running at
another frequency?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160128/99968045/attachment.sig>
