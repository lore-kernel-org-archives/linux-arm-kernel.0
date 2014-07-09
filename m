From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 Jul 2014 16:16:18 +0100
Subject: [PATCH RFC] drm: add of_graph endpoint helper to find possible
 CRTCs
In-Reply-To: <CAF6AEGtEUqK=YBWwOz8bf8a_e_p8-Y0vFYRfs2uxJ20015roOA@mail.gmail.com>
References: <E1X2kC1-0000sH-C6@rmk-PC.arm.linux.org.uk>
 <CAF6AEGtEUqK=YBWwOz8bf8a_e_p8-Y0vFYRfs2uxJ20015roOA@mail.gmail.com>
Message-ID: <20140709151618.GU21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 06:36:47PM -0400, Rob Clark wrote:
> On Thu, Jul 3, 2014 at 12:49 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> > Add a helper to allow encoders to find their possible CRTCs from the
> > OF graph without having to re-implement this functionality.  We add a
> > device_node to drm_crtc which corresponds with the port node in the
> > DT description of the CRTC device.
> >
> > We can then scan the DRM device list for CRTCs to find their index,
> > matching the appropriate CRTC using the port device_node, thus building
> > up the possible CRTC mask.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> > This helper will be shared between imx-drm and Armada DRM, and should
> > be useful for other OF-based drivers.  At the moment, this is being
> > sent for comments and acks; I need to build upon this patch in order
> > to convert Armada DRM to DT.
> >
> >  drivers/gpu/drm/Makefile |  1 +
> >  drivers/gpu/drm/drm_of.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/drm/drm_crtc.h   |  2 ++
> >  include/drm/drm_of.h     | 18 ++++++++++++++
> 
> oh, probably also should get links in Documentation/DocBook/drm.tmpl

Hmm... can you advise a suitable location... I've never touched that
stuff before, and it seems I can't even get it to build on my machine:

Warning(.../include/drm/drm_flip_work.h:68): No description found for parameter ')'
Warning(.../include/drm/drm_flip_work.h:68): Excess struct/union/enum/typedef member 'fifo' description in 'drm_flip_work'
Warning(.../include/drm/drm_flip_work.h:68): No description found for parameter ')'
Warning(.../include/drm/drm_flip_work.h:68): Excess struct/union/enum/typedef member 'fifo' description in 'drm_flip_work'
  DOCPROC Documentation/DocBook/w1.xml
  DOCPROC Documentation/DocBook/writing_musb_glue_layer.xml
  PDF     Documentation/DocBook/z8530book.pdf
Making portrait pages on A4 paper (210mmx297mm)
sh: /usr/share/xmlto/format/docbook/../fo/pdf: No such file or directory
make[2]: *** [Documentation/DocBook/z8530book.pdf] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [pdfdocs] Error 2
make: *** [sub-make] Error 2

I guess my install is too old for it.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
