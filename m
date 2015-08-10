From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 10 Aug 2015 14:21:36 +0200
Subject: [PATCH 00/12] dw-hdmi development
In-Reply-To: <20150808160251.GM7557@n2100.arm.linux.org.uk>
References: <20150808160251.GM7557@n2100.arm.linux.org.uk>
Message-ID: <20150810122135.GZ1262@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 08, 2015 at 05:02:51PM +0100, Russell King - ARM Linux wrote:
> This sub-series is a mixture of development:
> 
> * Removing the incorrect pixel repetition configuration code
> * Preventing pixel-doubled modes from being used
> * Adding interlaced video support
> * Implementing the sink_is_hdmi/sink_has_audio flags I suggested a few
>   months ago
> * Only enabling audio support if the sink indicates it has audio
> * Avoiding double-enabling the HDMI interface
> * Fixing the mis-leading name of "dw_hdmi_phy_enable_power"
> * Adding connector mode forcing (important if your monitor bounces
>   RXSENSE and HPD signals while in low-power mode.)
> * Improving the HDMI enable/disabling on sink status
> 
> For review (and testing if people feel like it).  Acks/tested-bys etc
> welcome.  It applies on top of my drm-dwhdmi-devel branch, which is
> waiting for David Airlie to pull (see pull request on dri-devel, 15th
> July.)

Hi Russell,

I have in the past merged patches for the bridge subdirectory via the
drm/panel tree, though lately much of the dw-hdmi patches have gone in
via Philipp or you directly. This seems to have worked fine so far, but
this time around I carry a patch to clean up Kconfig and Makefile a
little and bring more consistency to the subdirectory and I think it's
going to conflict with your series here (and potentially any ongoing
work you have).

Would you be open to me picking up these patches into the drm/panel
tree? It feeds into linux-next, so the code would get some exposure
before Dave's return.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150810/867cb263/attachment.sig>
