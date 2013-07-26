From: dwmw2@infradead.org (David Woodhouse)
Date: Fri, 26 Jul 2013 10:42:24 +0100
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <20130726080115.GA5436@netboy>
References: <CAOesGMhJ+je8FZqeFxhAcYwU0CHYer+aGP6DA_8x3azrzfA2sw@mail.gmail.com>
 <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <51F168FC.9070906@wwwdotorg.org>
 <20130725182920.GA24955@e106331-lin.cambridge.arm.com>
 <20130725184834.GA8296@netboy>
 <20130725213753.GC17616@obsidianresearch.com>
 <20130726080115.GA5436@netboy>
Message-ID: <1374831744.2923.42.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-07-26 at 10:01 +0200, Richard Cochran wrote:
> On Thu, Jul 25, 2013 at 03:37:53PM -0600, Jason Gunthorpe wrote:
> > 
> > We use DT has a kernel configuration input. Our environment is
> > designed to guarantee 100% that the kernel and DT match exactly. DT
> > very deliberately isn't an ABI boundary in our systems.
> 
> Think about what you just said.
> 
> The DT describes the *hardware* not the kernel. Why should you ever
> need to update your DT at all?

Well, the nodes which describe hardware devices, according to the
bindings which form an ABI contract between DT and drivers, should not
normally change. Although they *can* change, if for example you change
the MAC address and that's stored there. Or you change the PHY you want
it to use. Or something like that. The *ABI* doesn't change, but the
data you express *using* that ABI can change. That's kind of the point.

And the nodes in /chosen aren't describing hardware at all. Those are
*absolutely* expected to be configuration things. It's quite normal for
those to vary from one boot to the next, if your bootloader is
sophisticated enough to do that.

And if Jason wants to hard-code that kind of configuration data into his
device-tree and ship it as part of the overall system image that gets
installed, I see no particular problem with that.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130726/b2ffc9da/attachment.bin>
