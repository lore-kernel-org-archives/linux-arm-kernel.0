From: lukas@mntmn.com (Lukas Hartmann)
Date: Mon, 17 Jul 2017 17:58:45 +0200
Subject: Debugging i.MX6QP HDMI Output on Mainline Kernel
In-Reply-To: <1500304593.6594.35.camel@pengutronix.de>
References: <87d18z3yap.fsf@irata-debian.mntnas>
 <1500304593.6594.35.camel@pengutronix.de>
Message-ID: <BFC02E41-36FB-4B3C-83EB-D7B9A73EB9FC@mntmn.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

thanks for the quick response. I built the DTB with the kernel make in-tree before, yes.

I now tried just to boot with an almost unmodified imx6qp-nitrogen6_max.dts, just changing the chosen uart to uart1 and to my surprise it boots. I still get the same flip_done errors and 10s delays, but surprisingly, after waiting 10-20s, HDMI output works at 640x480 and I can see X on the screen for the first time!

Naturally USB and mmc/sd don't work now. I will tweak the DTS until these work and post a dmesg afterwards. 

Cheers
Lukas

> On 17. Jul 2017, at 17:16, Lucas Stach <l.stach@pengutronix.de> wrote:
> 
> Hi Lukas,
> 
> 
> 
> Am Montag, den 17.07.2017, 16:58 +0200 schrieb Lukas F. Hartmann:
>> Hello,
>> 
>> I'm trying, for several days full-time, to get HDMI Output working with
>> the mainline kernel (first 4.12, now 4.13-rc1) on a board called TinyRex
>> Ultra (incl. development baseboard), which has an i.MX6QP SoC and 4GB
>> RAM. The HDMI output works with freescale-linux 4.1 but not with
>> mainline. I'm willing to invest significant effort to make this work,
>> and I appreciate some direction from experts on the subject.
>> 
> In general HDMI output on i.MX6QP should work fine with kernel 4.12. I
> hope you aren't trying to get this to work with a downstream DT, but
> build your DT in the 4.12 source tree...
> 
>> I ported the DTS/DTSI files (mostly differing pinctrls) from the
>> third-party tinyrexultra DTS/DTSI. I modified the imx6qp-sabresd files
>> for this (attached). With this, most features of the board work fine,
>> e.g. SATA, USB, ethernet. I boot a debian-unstable userland from it.
>> 
> One thing I spotted is that you include the imx6q.dtsi, which isn't
> needed, as imx6qp.dtsi already includes it.
> 
> If you need an example, use the imx6qp-nitrogen6_max.dts. This board is
> mainline supported and I personally tested HDMI output to work there.
> 
>> When starting a program that uses DRM, e.g. Xorg, the program will pause
>> for 10 second intervals and DRM will log:
>> 
>> [ 127.831760] [drm:drm_atomic_helper_commit_cleanup_done] *ERROR* [CRTC:27:crtc-0] flip_done timed out
>> [ 138.711740] [drm:drm_atomic_helper_commit_cleanup_done] *ERROR* [CRTC:27:crtc-0] flip_done timed out
>> [ 148.951738] [drm:drm_atomic_helper_commit_cleanup_done] *ERROR*
>> [CRTC:27:crtc-0] flip_done timed out
>> 
> 
> Please post a full dmesg of a boot-up.
> 
> Regards,
> Lucas
> 
> 
