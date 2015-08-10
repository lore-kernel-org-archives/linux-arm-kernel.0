From: broonie@kernel.org (Mark Brown)
Date: Mon, 10 Aug 2015 19:16:41 +0100
Subject: [PATCH 1/9] drm: bridge/dw_hdmi-ahb-audio: add audio driver
In-Reply-To: <20150810164941.GW7557@n2100.arm.linux.org.uk>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hC-0003M5-EU@rmk-PC.arm.linux.org.uk>
 <s5hk2t35ui4.wl-tiwai@suse.de>
 <20150810103921.GR7557@n2100.arm.linux.org.uk>
 <s5hegjb5o44.wl-tiwai@suse.de>
 <20150810164941.GW7557@n2100.arm.linux.org.uk>
Message-ID: <20150810181641.GD10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 10, 2015 at 05:49:41PM +0100, Russell King - ARM Linux wrote:

> I'm not sure what the right solution is here: modifying every audio
> player out there to make HDMI work sanely is crazy.  Having alsalib
> automatically generate the correct AES channel status bytes for
> linear audio formats seems to be sensible, but difficult given its
> present structure with the defaults - the iec958 plugin has no idea
> if the defaults are being used or not.

> The advantage of having the horrid conversion in the kernel is that
> we can choose to generate proper AES channel status data without
> regard to userspace for standard linear PCM, and when the iec958 plugin
> is being used with proper channel status (eg, in compressed audio
> pass-through mode by VLC) then that works too.

The other advantage of doing it in kernel is that it also fixes tinyalsa
applications (which mainly means Android systems) by default for PCM
data.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150810/8d801c69/attachment.sig>
