From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Fri, 7 Nov 2014 00:01:45 +0100
Subject: N900 modem support in 3.18-rc1
In-Reply-To: <20141106225005.GA14002@amd>
References: <20141104205117.GA17606@amd>
 <20141106180335.GA21513@earth.universe> <20141106225005.GA14002@amd>
Message-ID: <201411070001.46481@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 November 2014 23:50:05 Pavel Machek wrote:
> > > What is needed to get voice calls to work?
> > 
> > There's still a kernel driver missing in mainline for
> > exchanging voice data between the modem and the cpu (called
> > cmt-speech).
> > 
> > BTW the CMT driver should be removed from your kernel tree;
> > its a deprecated variant of mainline's nokia-modem driver.
> > Thus I guess the cmt-speech driver, which is available in
> > your kernel tree, is not properly integrated into the
> > changes I did during mainlining the other modem related
> > drivers.
> 
> Aha, so CONFIG_CMT is the same thing as CONFIG_NOKIA_NODEM?
> Ok, will disable that. Speech... if you'd have version I
> could test, I'll happily do that.
> 
> Thanks,
> 									Pavel

For voice calls you need:
* kernel driver cmt-speech (or it has some new name)
* cmt-speech userspace library (communication with kernel)
* pulseaudio modules which are using that library

Freemangordon (Ivaylo Dimitrov, CCed) should know more about it, 
specially about pulseaudio modules...

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141107/db30e4f5/attachment.sig>
