From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 18 Jun 2014 16:11:06 +0200
Subject: Dove DT and HDMI on v3.16-rc1 (was: Re: [PATCH RFC 0/5] Dove PMU
 support)
In-Reply-To: <20140615152554.GA13870@n2100.arm.linux.org.uk>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk>
 <535E079B.6010701@gmail.com> <20140428083144.GB6650@lunn.ch>
 <535F6DAF.1010400@gmail.com> <20140615152554.GA13870@n2100.arm.linux.org.uk>
Message-ID: <53A19DFA.7030207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/15/2014 05:25 PM, Russell King - ARM Linux wrote:
> As for DT, I should probably state that I'm far from happy with the DT
> situation on Dove.  When I've tried it, I've encountered problems with
> the HDMI output - the picture spends more time blanked than displaying.
> I've no idea what is causing that, I've been through the SI5351
> registers, the TDA998x registers, the LCD controller registers, and I
> can't find any reason for it.  Yet, boot the same kernel without DT
> and it works fine.  Boot back using DT, and it's unstable again.
>
> I can't detect any difference on the actual HDMI signals themselves
> either.  The HDMI clock seems stable and of the correct frequency.
>
> There is definitely some difference between booting with DT and booting
> with legacy stuff that seems to upset HDMI.
>
> For me, the /only/ reliably working system is one where DT is not
> involved.  This means I remain opposed to any solutions which can't
> be used in a non-DT environment - at least until the HDMI issue can
> be resolved.

Russell,

as said on IRC, I really want this to be sorted out. I prepared a Dove
DT HDMI quick-hack and pushed it to

https://github.com/shesselba/linux-dove.git dove-drm-v3.16-rc1

Using your libdrm-armada and xf86-video-armada on Ubuntu raring armhf,
I can run Xfce4 on 1920x1080p60 on Dove Cubox without any blanking
issues. Using xrandr -s <mode> will fail after 2-3 times but that
shouldn't be related to the issues you see.

Please test above branch with kernel config at
https://dl.dropboxusercontent.com/u/59928252/config-dove-v3.16-rc1-hdmi
and report back if issues are still there.

Anyone having a Dove CuBox ready, please also test. Russell has a git
branch for the required video lib and drivers.

Sebastian
