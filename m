From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 29 Nov 2013 10:37:14 +0100
Subject: [RFC PATCH] Documentation: devicetree: add description for
 generic bus properties
In-Reply-To: <20131129023554.GA14239@kroah.com>
References: <20131127172806.GC2291@e103592.cambridge.arm.com>
 <20131128203322.GB14689@mithrandir>
 <20131128211009.GA26447@obsidianresearch.com>
 <20131128222232.GF14689@mithrandir>
 <20131128233147.GA19387@obsidianresearch.com>
 <20131129023554.GA14239@kroah.com>
Message-ID: <20131129093713.GC22771@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 28, 2013 at 06:35:54PM -0800, Greg KH wrote:
> On Thu, Nov 28, 2013 at 04:31:47PM -0700, Jason Gunthorpe wrote:
> > > Perhaps this is just another way of saying what Greg has already said.
> > > If we continue down this road, we'll eventually end up having to
> > > describe all sorts of nitty gritty details. And we'll need even more
> > 
> > Greg's point makes sense, but the HW guys are not designing things
> > this way for kicks - there are real physics based reasons for some of
> > these choices...
> > 
> > eg An all-to-all bus cross bar (eg like Intel's ring bus) is engery
> > expensive compared to a purpose built muxed bus tree. Doing coherency
> > look ups on DMA traffic costs energy, etc.
> 
> Really?  How much power exactly does it take / save?  Yes, hardware
> people think "software is free", but when you can't actually control the
> hardware in the software properly, well, you end up with something like
> itanium...
> 
> > > code to deal with those descriptions and the hardware they represent. At
> > > some point we need to start pushing some of the complexity back into
> > > hardware so that we can keep a sane code-base.
> > 
> > Some of this is a consequence of the push to have the firmware
> > minimal. As soon as you say the kernel has to configure the address
> > map you've created a big complexity for it..
> 
> Why the push to make firmware "minimal"?  What is that "saving"?  You
> just push the complexity from one place to the other, just because ARM
> doesn't seem to have good firmware engineers, doesn't mean they should
> punish their kernel developers :)

In my experience the biggest problem here is that people working on
upstream kernels and therefore confronted with these issues are seldom
able to track the latest developments of new chips.

When the time comes to upstream support, most of the functionality has
been implemented downstream already, so it actually works and there's no
apparent reason why things should change.

Now I know that that's not an ideal situation and upstreaming should
start a whole lot earlier, but even if that were the case, once the
silicon tapes out there's not a whole lot you can do about it anymore.
Starting with upstreaming even before that would have to be a solution,
but I don't think that's realistic at the current pace of development.

There's a large gap between how fast new SoCs are supposed to tape out
and the rate at which new code can be merged upstream. Perhaps some of
that could be mitigated by putting more of the complexity into firmware
and that's already happening to some degree for ARMv8. But I suspect
there's a limit to what you can hide away in firmware while at the same
time giving the kernel enough information to do the right thing.

I am completely convinced that our goal should be to do upstreaming
early and ideally there shouldn't be any downstream development in the
first place. The reason why we're not there yet is because it isn't
practical to do so currently, so I'm very interested in suggestions or
finding ways to improve the situation.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131129/e1534e12/attachment-0001.sig>
