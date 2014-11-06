From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 6 Nov 2014 19:03:36 +0100
Subject: N900 modem support in 3.18-rc1
In-Reply-To: <20141106124711.GA26944@amd>
References: <20141104205117.GA17606@amd> <201411052137.31452@pali>
 <20141105203918.GA29199@amd> <201411052206.05379@pali>
 <20141105220359.GA32052@amd> <20141105234555.GA7097@earth.universe>
 <20141106124711.GA26944@amd>
Message-ID: <20141106180335.GA21513@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 06, 2014 at 01:47:11PM +0100, Pavel Machek wrote:
> > On Wed, Nov 05, 2014 at 11:03:59PM +0100, Pavel Machek wrote:
> > > > Maybe you need to enable modem?
> > > > 
> > > > This is n900 init sequence from script: nokia-n900-configs.sh
> > > 
> > > From the dts, it looks like this should somehow work without this.
> > 
> > Right :) The n900-modem driver will take care of this if the "pm"
> > parameter is set to 1 (which should be the default).
> 
> I actually had pm=0 on the command line, but I removed it now, and no
> change: [...]
> 
> Let me try with explicit =1. .. aha, that helps. Thanks!

mh seems I actually missed to make 1 the default value. I will
prepare a patch for that.

I assume, that the example ofono commands work for you now?

> Do you have an example client that can talk to ofonod?

I have not yet played with userland stuff. You could try
telepathy-ring, which integrates the ofono into the telepathy
framework.

> What is needed to get voice calls to work?

There's still a kernel driver missing in mainline for exchanging
voice data between the modem and the cpu (called cmt-speech).

BTW the CMT driver should be removed from your kernel tree; its a
deprecated variant of mainline's nokia-modem driver. Thus I guess
the cmt-speech driver, which is available in your kernel tree, is
not properly integrated into the changes I did during mainlining
the other modem related drivers.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141106/5aa320d1/attachment.sig>
