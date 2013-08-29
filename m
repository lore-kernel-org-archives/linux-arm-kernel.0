From: broonie@kernel.org (Mark Brown)
Date: Thu, 29 Aug 2013 18:12:10 +0100
Subject: [PATCH 1/2] ARM: Dove: Add the audio devices in DT
In-Reply-To: <20130829163358.GS6617@n2100.arm.linux.org.uk>
References: <20130828113459.48ecbb34@armhf> <521DCD33.2070008@gmail.com>
 <20130828121943.1c8327ca@skate> <521DD057.4040208@gmail.com>
 <20130829161217.GK10783@sirena.org.uk>
 <20130829163358.GS6617@n2100.arm.linux.org.uk>
Message-ID: <20130829171210.GM10783@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 29, 2013 at 05:33:58PM +0100, Russell King - ARM Linux wrote:
> On Thu, Aug 29, 2013 at 05:12:17PM +0100, Mark Brown wrote:
> > On Wed, Aug 28, 2013 at 12:26:31PM +0200, Sebastian Hesselbarth wrote:

> > > Also, we'll need to distinguish between the different audio controllers
> > > on a single SoC, i.e. i2s0 and i2s1. I suggest checking the (phys) reg
> > > base passed.

> > Why is this required - ideally this would have been mentioned in some of
> > the previous reviews...

> I've mentioned the differences between the blocks to you repeatedly in
> our massive thread, including that some contain the block with different

You have described some additional features which will require
additional driver support.  I would expect that the device tree bindings
for these features would be added as the features are added and the DTS
files updated, for example by listing additional compatible strings if
that was the binding update, as is the normal practice.  Obviously any
hardware which is not compatible with the current binding should not be
being registered using the current binding.

It is not clear from the above comment by Sebastian if he is referring
to the same set of hardware differences or something new - doing things
based on device address is highly unusual, it sounds like something to
do with the integration into the SoC rather than to do with the IP.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130829/45a367c1/attachment.sig>
