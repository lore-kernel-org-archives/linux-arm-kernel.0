From: marex@denx.de (Marek Vasut)
Date: Sun, 10 Nov 2013 18:48:11 +0100
Subject: [PATCH 2/3] ARM: mxs: crypto: Add Freescale MXS DCP driver
In-Reply-To: <201310081233.37136.marex@denx.de>
References: <1380194306-5243-1-git-send-email-marex@denx.de>
 <20131008043631.GA18365@gondor.apana.org.au>
 <201310081233.37136.marex@denx.de>
Message-ID: <201311101848.12215.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> Hello Herbert,
> 
> > On Mon, Oct 07, 2013 at 05:48:26PM +0200, Marek Vasut wrote:
> > > Hello Christoph,
> > > 
> > > > Hello Marek,
> > > > 
> > > > > Marek Vasut <marex@denx.de> hat am 28. September 2013 um 05:35
> > > > > geschrieben: [...]
> > > > > 
> > > > > > > 3) What are those ugly new IOCTLs in the dcp.c driver?
> > > > > > 
> > > > > > When I firstly posted the driver in the mailinglist, there where
> > > > > > one person who actually used this interface (it was introduced in
> > > > > > Freescale's SDK) to use the OTP keys for crypto. As far as I have
> > > > > > seen, the crypto API does not support such keys (i.e. there seems
> > > > > > to be no way to tell a driver to use some kind of special keys -
> > > > > > which are not delivered by the user - via the API).
> > > > > > Therefore I added this miscdevice and adopted Freescale's
> > > > > > interface.
> > > > > 
> > > > > The keys are programmed into the OTP registers, correct? There is
> > > > > OCOTP d
> > > > >
> > > > >river
> > > > >for the MX23/MX28 OTP hardware. This is what should have been used
> > > > >then.
> > > > >
> > > > > NOTE: This IOCTL interface seems like quite an abusive way to allow
> > > > > userl
> > > > >
> > > > >and to
> > > > >access the crypto API in kernel. I understand this is used by some
> > > > >Freesc ale tool, but won't it be better to fix the Freescale tool
> > > > >instead ?
> > > > 
> > > > the IOCTL interface is used to AES encrypt a bootstream with the AES
> > > > key in OCOTP.
> > > > The idea is that only the DCP can read/access the key once it has
> > > > been programmed
> > > > into the OCOTP. If the crypto API has means to tell the DCP to use
> > > > the key from OCOTP, the tool from Freescale is a minor problem.
> > > 
> > > Ah right. I suspect the crypto API services shall not be exported into
> > > userland at all, yes ? So there has to be some kind of workaround here
> > > for this freescale tool, which is rather unfortunate.
> > 
> > These ioctls have to go.  I should have never let them through in
> > the first place.  Can someone cook up a patch to kill them please?
> 
> I can do that. I wonder if we can't agree to nuke the in-tree driver
> altogether instead and replace it by this one though. Does it not sound
> more reasonable?

Bump?

Best regards,
Marek Vasut
