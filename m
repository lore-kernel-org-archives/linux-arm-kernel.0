From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Aug 2015 11:37:42 +0100
Subject: [PATCH 00/12] dw-hdmi development
In-Reply-To: <20150810122135.GZ1262@ulmo.nvidia.com>
References: <20150808160251.GM7557@n2100.arm.linux.org.uk>
 <20150810122135.GZ1262@ulmo.nvidia.com>
Message-ID: <20150818103742.GN7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 10, 2015 at 02:21:36PM +0200, Thierry Reding wrote:
> On Sat, Aug 08, 2015 at 05:02:51PM +0100, Russell King - ARM Linux wrote:
> > This sub-series is a mixture of development:
> > 
> > * Removing the incorrect pixel repetition configuration code
> > * Preventing pixel-doubled modes from being used
> > * Adding interlaced video support
> > * Implementing the sink_is_hdmi/sink_has_audio flags I suggested a few
> >   months ago
> > * Only enabling audio support if the sink indicates it has audio
> > * Avoiding double-enabling the HDMI interface
> > * Fixing the mis-leading name of "dw_hdmi_phy_enable_power"
> > * Adding connector mode forcing (important if your monitor bounces
> >   RXSENSE and HPD signals while in low-power mode.)
> > * Improving the HDMI enable/disabling on sink status
> > 
> > For review (and testing if people feel like it).  Acks/tested-bys etc
> > welcome.  It applies on top of my drm-dwhdmi-devel branch, which is
> > waiting for David Airlie to pull (see pull request on dri-devel, 15th
> > July.)
> 
> Hi Russell,
> 
> I have in the past merged patches for the bridge subdirectory via the
> drm/panel tree, though lately much of the dw-hdmi patches have gone in
> via Philipp or you directly. This seems to have worked fine so far, but
> this time around I carry a patch to clean up Kconfig and Makefile a
> little and bring more consistency to the subdirectory and I think it's
> going to conflict with your series here (and potentially any ongoing
> work you have).
> 
> Would you be open to me picking up these patches into the drm/panel
> tree? It feeds into linux-next, so the code would get some exposure
> before Dave's return.

I haven't seen any acks or comments on this set of 12 patches yet which
is rather disappointing.

David has now returned, and as David hasn't pulled stuff from the 15th,
my intention is to re-send that pull request, but with certain patches
from this set included in that - patches 1, 2, 6, 7, 8, 9 and 10.  I'll
also include Vladimir Zapolskiy's "fix register I2CM_ADDRESS register
name" patch in the set too.

None of that touches the Makefile or Kconfig, so there shouldn't be any
conflicts with your work.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
