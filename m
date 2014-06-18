From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 18 Jun 2014 11:34:48 -0300
Subject: Dove DT and HDMI on v3.16-rc1 (was: Re: [PATCH RFC 0/5] Dove PMU
 support)
In-Reply-To: <53A19DFA.7030207@gmail.com>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk>
 <535E079B.6010701@gmail.com> <20140428083144.GB6650@lunn.ch>
 <535F6DAF.1010400@gmail.com>
 <20140615152554.GA13870@n2100.arm.linux.org.uk>
 <53A19DFA.7030207@gmail.com>
Message-ID: <20140618143447.GA22890@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 Jun 04:11 PM, Sebastian Hesselbarth wrote:
> On 06/15/2014 05:25 PM, Russell King - ARM Linux wrote:
> >As for DT, I should probably state that I'm far from happy with the DT
> >situation on Dove.  When I've tried it, I've encountered problems with
> >the HDMI output - the picture spends more time blanked than displaying.
> >I've no idea what is causing that, I've been through the SI5351
> >registers, the TDA998x registers, the LCD controller registers, and I
> >can't find any reason for it.  Yet, boot the same kernel without DT
> >and it works fine.  Boot back using DT, and it's unstable again.
> >
> >I can't detect any difference on the actual HDMI signals themselves
> >either.  The HDMI clock seems stable and of the correct frequency.
> >
> >There is definitely some difference between booting with DT and booting
> >with legacy stuff that seems to upset HDMI.
> >
> >For me, the /only/ reliably working system is one where DT is not
> >involved.  This means I remain opposed to any solutions which can't
> >be used in a non-DT environment - at least until the HDMI issue can
> >be resolved.
> 
> Russell,
> 
> as said on IRC, I really want this to be sorted out. I prepared a Dove
> DT HDMI quick-hack and pushed it to
> 
> https://github.com/shesselba/linux-dove.git dove-drm-v3.16-rc1
> 

I can probably give a quick test to this using Qt over FB, or just
plain fb-test / libdrm tests. But you are already doing a more involved
test, so maybe my tests are too simple.

> Using your libdrm-armada and xf86-video-armada on Ubuntu raring armhf,
> I can run Xfce4 on 1920x1080p60 on Dove Cubox without any blanking
> issues. Using xrandr -s <mode> will fail after 2-3 times but that
> shouldn't be related to the issues you see.
> 
> Please test above branch with kernel config at
> https://dl.dropboxusercontent.com/u/59928252/config-dove-v3.16-rc1-hdmi
> and report back if issues are still there.
> 
> Anyone having a Dove CuBox ready, please also test. Russell has a git
> branch for the required video lib and drivers.
> 

Can you point me at those?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
