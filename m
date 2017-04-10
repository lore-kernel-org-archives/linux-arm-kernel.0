From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Apr 2017 13:44:21 +0100
Subject: [PATCH 0/2] drm: dw-hdmi: various improvements
In-Reply-To: <20170410120844.3czcqwjsyzmkznhp@phenom.ffwll.local>
References: <20170407141905.14147-1-romain.perier@collabora.com>
 <f0ff38c5-46f0-0702-ca68-ccebf5b8c910@codeaurora.org>
 <20170410100807.GN17774@n2100.armlinux.org.uk>
 <5b7e5643-e86d-37ac-e220-c81e34af13ba@baylibre.com>
 <20170410120844.3czcqwjsyzmkznhp@phenom.ffwll.local>
Message-ID: <20170410124420.GQ17774@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 10, 2017 at 02:08:44PM +0200, Daniel Vetter wrote:
> On Mon, Apr 10, 2017 at 12:35:43PM +0200, Neil Armstrong wrote:
> > On 04/10/2017 12:08 PM, Russell King - ARM Linux wrote:
> > > On Mon, Apr 10, 2017 at 10:49:18AM +0530, Archit Taneja wrote:
> > >> Hi,
> > >>
> > >> On 04/07/2017 07:49 PM, Romain Perier wrote:
> > >>> This set of patches split the stream handling functions in two parts. It
> > >>> introduces new callbacks that are specific to each variant, one for I2S
> > >>> and one for AHB.
> > >>>
> > >>> Then, as requested by the datasheet for the I2S variant, it adds support
> > >>> for gating the audio sampler clock when the audio stream is enabled and
> > >>> disabled.
> > >>>
> > >>> This patches series is the continuity of the following discussion:
> > >>> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/493550.html
> > >>
> > >> Since these aren't fixes, could you make sure to redo the patches over:
> > >>
> > >> git://anongit.freedesktop.org/drm-misc drm-misc-next
> > >>
> > >> The dw-hdmi driver is now under drivers/gpu/drm/bridge/synopsis/
> > > 
> > > This is annoying as it makes submission of CEC support for dw-hdmi
> > > rather difficult due to the now horrid cross-tree dependencies:
> > > 
> > > * if I submit it to the DRM tree, the DRM tree will build break because
> > >   you don't have the necessary CEC changes which have recently been
> > >   merged into the media tree.
> > > 
> > > * if I submit it to the media tree, the new files will be placed into
> > >   drivers/gpu/drm/bridge and when stuff gets merged into linux-next
> > >   and/or Linus' tree, things will need quite a large fixup (someone
> > >   will have to rename the files and fix the Kconfig/Makefiles.)
> > > 
> > > So, I'll hold it back for another cycle to avoid the mess that would
> > > result from trying to get it merged during this cycle.
> > > 
> > 
> > Hi Russell,
> > 
> > Cross tree with media has already been done on this cycle with the
> > dw-hdmi formats changes.
> > 
> > Nevertheless, please push your updated dw-hdmi cec patchset for tests
> > and review based on the latest drm-misc-next and hverkuil's HPD notifier
> > release.
> > 
> > I would like to run it on some Amlogic boards.
> 
> Yeah, cross subsystem topic branches aren't rocket science, we have the
> entire process documented and scripted on the drm side. Hairy depencies
> really aren't a reason to not submit patches, we've got this :-)
> 
> But 4.12 is done anyway on the drm side, so will get delayed to 4.13 no
> matter what. Still would be good to get the patches reviewed as early as
> possible.

Maybe if I had infinite bandwidth, then that would happen, but I don't.
That makes it very low priority for me, as there's no benefit to me to
spending time on it before the merge window, and if I wait until after
the merge window, things get easier, and I don't have to pollute my tree
with unmerged changes from other trees.  So there's actually beneficial
reasons for me to do nothing on this right now.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
