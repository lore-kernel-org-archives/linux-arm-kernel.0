From: balbi@ti.com (Felipe Balbi)
Date: Thu, 18 Oct 2012 20:23:50 +0300
Subject: [RFC/NOT FOR MERGING 3/5] arm: omap: introduce other PM methods
In-Reply-To: <20121018170640.GB6641@arwen.pp.htv.fi>
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
 <1350488043-5053-4-git-send-email-balbi@ti.com>
 <878vb3g14c.fsf@deeprootsystems.com>
 <20121018170640.GB6641@arwen.pp.htv.fi>
Message-ID: <20121018172350.GA6914@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 18, 2012 at 08:06:40PM +0300, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Oct 18, 2012 at 10:07:31AM -0700, Kevin Hilman wrote:
> > Felipe Balbi <balbi@ti.com> writes:
> > 
> > > current omap_device PM implementation defines
> > > omap-specific *_noirq methods but uses the
> > > generic versions for all other PM methods.
> > >
> > > As it turns out, if a device decides to implement
> > > non-runtime PM callbacks, we might fall into a
> > > situation where the hwmod is still idled which
> > > will generate an abort exception when we try
> > > to access device's address space while clocks
> > > are still gated.
> > 
> > Please explain in more detail how this could happen.
> 
> just follow the patchset. If I implement system suspend and I'm not
> focefully calling runtime_* methods, who will be there to call
> omap_device_enable() ?

let me rephrase this. If we exit _noirq right in the beginning with the
extra check I've added, who will call omap_device_enable() ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121018/dca978dd/attachment.sig>
