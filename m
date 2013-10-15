From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Oct 2013 11:00:26 +0100
Subject: [PATCH v2 2/3] ARM: dts: imx6qdl-wandboard: Add HDMI support
In-Reply-To: <CAOMZO5BRmXav-qj4DqvTJASfU98sJ3zpHHZBk7s4pCkDd0Z85Q@mail.gmail.com>
References: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
 <1380826287-30253-2-git-send-email-fabio.estevam@freescale.com>
 <20131014173824.GT25034@n2100.arm.linux.org.uk>
 <CAOMZO5BRmXav-qj4DqvTJASfU98sJ3zpHHZBk7s4pCkDd0Z85Q@mail.gmail.com>
Message-ID: <20131015100025.GX25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 14, 2013 at 11:47:17PM -0300, Fabio Estevam wrote:
> On Mon, Oct 14, 2013 at 2:38 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > Shouldn't the above be in patch 1 (or 1.5) rather than patch 2?  Patch 2
> > advertises itself as adding support for the wandboard, but in actual
> > fact it's adding the generic bits too.
> 
> Thanks for your review. Will address your comments in v3.
> 
> Philipp Zabel mentioned that he will move imx-drm out of staging, so
> will send v3 after Philipp's patch gets into linux-next.

That's unfortunate, especially given the bug with the clock polarity
(which, although I can tweak the register directly, it's not obvious
that changing the clk_pol initialisation is the correct solution.)

There's also another issue here: the lack of DRM prime support.  As
you have a separate GPU and separate VPU, you really need dmabuf
support implemented so that you can hand your scanout buffers/overlays
to other subsystems.
