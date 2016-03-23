From: broonie@kernel.org (Mark Brown)
Date: Wed, 23 Mar 2016 13:27:32 +0000
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <56F295E1.4030505@denx.de>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <20160322173546.40d24cc2@free-electrons.com>
 <56F17684.2010307@denx.de> <20160323113316.GH2566@sirena.org.uk>
 <56F2852C.5010006@denx.de> <20160323125448.GM2566@sirena.org.uk>
 <56F295E1.4030505@denx.de>
Message-ID: <20160323132732.GN2566@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 02:10:57PM +0100, Stefan Roese wrote:
> On 23.03.2016 13:54, Mark Brown wrote:

> > I haven't looked at your new code at all.  What I'm saying is that
> > specifying a per-device MBus window seems like pointless complexity.

> I don't necessarily share this opinions. Code-wise, its less complex
> that re-configuring (removing the old and creating the new) the MBus
> window. But I have no strong feeling here. Whatever is decided that
> should be used, I can go with.

No, really - it's just unhelpful.  Putting this in the ABI means that
every single system integrator who cares about performance is going to
need to go and manually figure out how to configure this in DT and
manually select values.  That's not doing a good job for users, it's
making their lives harder for no gain.  If there are no physical
constraints then how we allocate space in the MBus should be a runtime
thing, it shouldn't be part of the ABI.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160323/806cfe06/attachment.sig>
