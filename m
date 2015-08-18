From: eric@anholt.net (Eric Anholt)
Date: Tue, 18 Aug 2015 13:56:24 -0700
Subject: [PATCH 3/7] drm/vc4: Add KMS support for Raspberry Pi.
In-Reply-To: <20150813211755.GE17734@phenom.ffwll.local>
References: <1439427380-2436-1-git-send-email-eric@anholt.net>
 <1439427380-2436-4-git-send-email-eric@anholt.net>
 <20150813075141.GX17734@phenom.ffwll.local>
 <87d1yqq5po.fsf@eliezer.anholt.net>
 <20150813211755.GE17734@phenom.ffwll.local>
Message-ID: <87y4h8iadj.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Vetter <daniel@ffwll.ch> writes:

> On Thu, Aug 13, 2015 at 01:44:03PM -0700, Eric Anholt wrote:
>> Daniel Vetter <daniel@ffwll.ch> writes:
>> 
>> > On Wed, Aug 12, 2015 at 05:56:16PM -0700, Eric Anholt wrote:
>> >> This is the start of a full VC4 driver.  Right now this just supports
>> >> configuring the display using a pre-existing video mode (because
>> >> changing the pixel clock isn't available yet, and doesn't work when it
>> >> is).  However, this is enough for fbcon and bringing up X using
>> >> xf86-video-modesetting.
>> >> 
>> >> Signed-off-by: Eric Anholt <eric@anholt.net>
>> >> ---
>> >>  drivers/gpu/drm/Kconfig           |   2 +
>> >>  drivers/gpu/drm/Makefile          |   1 +
>> >>  drivers/gpu/drm/vc4/Kconfig       |  14 +
>> >>  drivers/gpu/drm/vc4/Makefile      |  18 ++
>> >>  drivers/gpu/drm/vc4/vc4_bo.c      |  54 ++++
>> >>  drivers/gpu/drm/vc4/vc4_crtc.c    | 583 ++++++++++++++++++++++++++++++++++
>> >>  drivers/gpu/drm/vc4/vc4_debugfs.c |  38 +++
>> >>  drivers/gpu/drm/vc4/vc4_drv.c     | 249 +++++++++++++++
>> >>  drivers/gpu/drm/vc4/vc4_drv.h     | 123 +++++++
>> >>  drivers/gpu/drm/vc4/vc4_hdmi.c    | 651 ++++++++++++++++++++++++++++++++++++++
>> >>  drivers/gpu/drm/vc4/vc4_hvs.c     | 172 ++++++++++
>> >>  drivers/gpu/drm/vc4/vc4_kms.c     |  84 +++++
>> >>  drivers/gpu/drm/vc4/vc4_plane.c   | 320 +++++++++++++++++++
>> >>  drivers/gpu/drm/vc4/vc4_regs.h    | 562 ++++++++++++++++++++++++++++++++
>> >>  14 files changed, 2871 insertions(+)
>> >>  create mode 100644 drivers/gpu/drm/vc4/Kconfig
>> >>  create mode 100644 drivers/gpu/drm/vc4/Makefile
>> >>  create mode 100644 drivers/gpu/drm/vc4/vc4_bo.c
>> >>  create mode 100644 drivers/gpu/drm/vc4/vc4_crtc.c
>> >>  create mode 100644 drivers/gpu/drm/vc4/vc4_debugfs.c
>> >>  create mode 100644 drivers/gpu/drm/vc4/vc4_drv.c
>> >>  create mode 100644 drivers/gpu/drm/vc4/vc4_drv.h
>> >>  create mode 100644 drivers/gpu/drm/vc4/vc4_hdmi.c
>> >>  create mode 100644 drivers/gpu/drm/vc4/vc4_hvs.c
>> >>  create mode 100644 drivers/gpu/drm/vc4/vc4_kms.c
>> >>  create mode 100644 drivers/gpu/drm/vc4/vc4_plane.c
>> >>  create mode 100644 drivers/gpu/drm/vc4/vc4_regs.h
>> >
>> > Made a quick pass and found a few things to update to latest drm
>> > developments. Of course didn't look at the hardware details since no clue,
>> > but looks really nice overall.
>> 
>> If you have anything about the hardware that you were curious about, I'd
>> be interested in trying to explain them in the comments to the extent
>> that I can.  It's unfortunate that we haven't shipped docs for the
>> display side of things, but had to do a lot of reading of the verilog
>> just to get this far, anyway.
>
> The only thing I spotted is that you right now only register a primary and
> cursor plane. I guess the plan we once discussed about exposing piles of
> planes for -modesetting accel isn't there yet?
>
> But otherwise I really didn't go into the hardware details.

Yeah, I haven't done piles of planes because what we have right now
means I don't have to do the bandwidth limits tracking yet.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150818/efaeaf36/attachment.sig>
