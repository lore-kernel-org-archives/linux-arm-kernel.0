From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Jul 2013 15:14:30 +0100
Subject: [RFC 0/1] drm/pl111: Initial drm/kms driver for pl111
In-Reply-To: <CAF6AEGtspnhSGNM4_QQubVfOkZ1Gh1-Z3iyHOLBPVWuqRy81ew@mail.gmail.com>
References: <1374772648-19151-1-git-send-email-tom.cooksey@arm.com>
 <CAF6AEGtspnhSGNM4_QQubVfOkZ1Gh1-Z3iyHOLBPVWuqRy81ew@mail.gmail.com>
Message-ID: <20130726141430.GQ24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 02:21:59PM -0400, Rob Clark wrote:
> On Thu, Jul 25, 2013 at 1:17 PM,  <tom.cooksey@arm.com> wrote:
> > Known issues:
> >  * It uses KDS. We intend to switch to whatever implicit per-buffer
> >    synchronisation mechanism gets merged, once something is merged.
> >  * It abuses flags parameter of DRM_IOCTL_MODE_CREATE_DUMB to also
> >    allocate buffers for the GPU. Still not sure how to resolve this
> >    as we don't use DRM for our GPU driver.
> 
> any thoughts/plans about a DRM GPU driver?  Ideally long term (esp.
> once the dma-fence stuff is in place), we'd have gpu-specific drm
> (gpu-only, no kms) driver, and SoC/display specific drm/kms driver,
> using prime/dmabuf to share between the two.

The PL111 primecell is just a scanout device.  It has no GPU embedded
in it.  It's just like the Armada/Dove DRM stuff - if a GPU is provided
it's an entirely separate piece of IP, and will likely remain a separate
non-DRM driver.

In the case of PL111, PL111 is not manufacturer specific so the GPU can
be any standalone GPU.
