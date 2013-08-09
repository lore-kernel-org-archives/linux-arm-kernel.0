From: broonie@kernel.org (Mark Brown)
Date: Fri, 9 Aug 2013 20:44:34 +0100
Subject: [PATCH v4 1/1] ASoc: kirkwood: add DT support to the mvebu audio
 subsystem
In-Reply-To: <20130809182516.GT23006@n2100.arm.linux.org.uk>
References: <20130808132201.2610aef3@armhf> <5204A716.6070507@gmail.com>
 <20130809091953.GO6427@sirena.org.uk> <5204B7A6.9050907@gmail.com>
 <20130809094340.GO23006@n2100.arm.linux.org.uk>
 <5204CC04.4000401@gmail.com> <20130809113940.GY6427@sirena.org.uk>
 <20130809130932.GS23006@n2100.arm.linux.org.uk>
 <20130809180058.GM6427@sirena.org.uk>
 <20130809182516.GT23006@n2100.arm.linux.org.uk>
Message-ID: <20130809194434.GP6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 07:25:16PM +0100, Russell King - ARM Linux wrote:

> Sigh, you completely miss the point.

> What all three of us are ultimately after is a DT description for the
> kirkwood stuff which covers all its use cases.  The use case which all
> three of us have in common is the Cubox, which is the one which needs
> the spdif stuff to work.

I think I get what needs to be done well enough, I'm not sure that
matches up with what people are wanting the results to look like but
that's another story.

> Now, what you've said to date is:

> 1. you want kirkwood to use DPCM.

Yes.

> 2. you want kirkwood using people to use the simple card stuff with the
>    kirkwood driver you want to use DPCM.

No.  What I'm saying is that if your end goal is a binding for cards
that works for absolutely anything then it should be handled by the
simple card driver since that's what it's there for.   There's no
requirement to do things that way though, certainly not in a first pass.

> To make it work with DPCM, we first need to know what DPCM requires,
> which means we either have to have the knowledge of DPCM and/or have a
> working implementation.  We don't have either of those yet.

> So, I again state plainly that what you're asking is for people to come
> up with a DT description for a DPCM implementation when we haven't yet
> got a working DPCM implementation, even without DT.

> It is this which I assert is a completely rediculous request at this
> moment in time for the reasons stated in my previous email and repeated
> in this email.

I'm not sure I said that anyone need do anything right this very minute?  

In any case since the binding that pulls everything together into the
audio subsystem is supposed to be separate to the bindings for the
bindings for individual components it should be possible to proceed with
those if someone wants to do that (as in the patch under discussion) and
add the bits to tie things together later.

If someone wants to it should also be possible to convert the existing
platforms without S/PDIF support over to DT, providing you don't mind
changing the code once the DPCM and S/PDIF support is added and a bit of
thought is put into where the S/PDIF output will fit into the bindings.
Since DPCM is a Linux internal thing it shouldn't have any impact on the
bindings.

But like I say there's no need to do anything in particular immediately.
The patch under discussion seems basically fine for what it covers,
modulo the fairly minor things Sebastian identified, and can be built on
later.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130809/b0376bfa/attachment.sig>
