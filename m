From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 17 Jul 2017 17:16:33 +0200
Subject: Debugging i.MX6QP HDMI Output on Mainline Kernel
In-Reply-To: <87d18z3yap.fsf@irata-debian.mntnas>
References: <87d18z3yap.fsf@irata-debian.mntnas>
Message-ID: <1500304593.6594.35.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukas,



Am Montag, den 17.07.2017, 16:58 +0200 schrieb Lukas F. Hartmann:
> Hello,
> 
> I'm trying, for several days full-time, to get HDMI Output working with
> the mainline kernel (first 4.12, now 4.13-rc1) on a board called TinyRex
> Ultra (incl. development baseboard), which has an i.MX6QP SoC and 4GB
> RAM. The HDMI output works with freescale-linux 4.1 but not with
> mainline. I'm willing to invest significant effort to make this work,
> and I appreciate some direction from experts on the subject.
> 
In general HDMI output on i.MX6QP should work fine with kernel 4.12. I
hope you aren't trying to get this to work with a downstream DT, but
build your DT in the 4.12 source tree...

> I ported the DTS/DTSI files (mostly differing pinctrls) from the
> third-party tinyrexultra DTS/DTSI. I modified the imx6qp-sabresd files
> for this (attached). With this, most features of the board work fine,
> e.g. SATA, USB, ethernet. I boot a debian-unstable userland from it.
> 
One thing I spotted is that you include the imx6q.dtsi, which isn't
needed, as imx6qp.dtsi already includes it.

If you need an example, use the imx6qp-nitrogen6_max.dts. This board is
mainline supported and I personally tested HDMI output to work there.

> When starting a program that uses DRM, e.g. Xorg, the program will pause
> for 10 second intervals and DRM will log:
> 
> [ 127.831760] [drm:drm_atomic_helper_commit_cleanup_done] *ERROR* [CRTC:27:crtc-0] flip_done timed out
> [ 138.711740] [drm:drm_atomic_helper_commit_cleanup_done] *ERROR* [CRTC:27:crtc-0] flip_done timed out
> [ 148.951738] [drm:drm_atomic_helper_commit_cleanup_done] *ERROR*
> [CRTC:27:crtc-0] flip_done timed out
> 

Please post a full dmesg of a boot-up.

Regards,
Lucas
