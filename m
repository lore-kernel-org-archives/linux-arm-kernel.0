From: grant.likely@linaro.org (Grant Likely)
Date: Sat, 01 Mar 2014 19:20:41 +0000
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <20140226222553.GF16149@cbox>
References: <20140226183454.GA14639@cbox> <5553754.0b4gMg5OS7@wuerfel> <
 20140226214843.GD12169@bivouac.eciton.net> <20140226222553.GF16149@cbox>
Message-ID: <20140301192041.40196C4089C@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Feb 2014 14:25:53 -0800, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Wed, Feb 26, 2014 at 09:48:43PM +0000, Leif Lindholm wrote:
> > On Wed, Feb 26, 2014 at 08:55:58PM +0100, Arnd Bergmann wrote:
> > > On Wednesday 26 February 2014 10:34:54 Christoffer Dall wrote:
> > > > ARM VM System Specification
> > > > ===========================
> > > > 
> > > > Goal
> > > > ----
> > > > The goal of this spec is to allow suitably-built OS images to run on
> > > > all ARM virtualization solutions, such as KVM or Xen.
> > > > 
> > > > Recommendations in this spec are valid for aarch32 and aarch64 alike, and
> > > > they aim to be hypervisor agnostic.
> > > > 
> > > > Note that simply adhering to the SBSA [2] is not a valid approach,
> > > > for example because the SBSA mandates EL2, which will not be available
> > > > for VMs.  Further, the SBSA mandates peripherals like the pl011, which
> > > > may be controversial for some ARM VM implementations to support.
> > > > This spec also covers the aarch32 execution mode, not covered in the
> > > > SBSA.
> > > 
> > > I would prefer if we can stay as close as possible to SBSA for individual
> > > hardware components, and only stray from it when there is a strong reason.
> > > pl011-subset doesn't sound like a significant problem to implement,
> > > especially as SBSA makes the DMA part of that optional. Can you
> > > elaborate on what hypervisor would have a problem with that?
> > 
> > I believe it comes down to how much extra overhead pl011-access-trap
> > would be over virtio-console. If low, then sure.
> > (Since there are certain things we cannot provide SBSA-compliant in
> > the guest anyway, I wouldn't consider lack of pl011 to be a big issue.)
> > 
> 
> I don't think it's about overhead, sure pl011 may be slower, but it's a
> serial port, does anyone care about performance of a console? pl011
> should be good enough for sure.

The reason pl011 is specified in the SBSA is to have a reliable output
port available from the first instruction. It is a debug feature.
Hardware vendors aren't even need to wire it up to a physical serial
port. It is just as valid to wire it to the RAS controller.

g.
