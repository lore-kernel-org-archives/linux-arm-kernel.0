From: david.woodhouse@intel.com (Woodhouse, David)
Date: Fri, 27 Sep 2013 10:59:16 +0000
Subject: [GIT PULL] ARM: SoC fixes for 3.12-rc
In-Reply-To: <CAN8TOE8Xf9fv9zyY6wof3b9QhqgV=s-cK4V4D6n+Gw4HgacT0g@mail.gmail.com>
References: <20130919194752.GA19975@quad.lixom.net>
 <1379626776.753.164.camel@shinybook.infradead.org>
 <CAN8TOE8j=oosn-5hAdqoTPcuW-sGvDAHd_nK6BZfJpxMwwpisQ@mail.gmail.com>
 <1379632757.12963.4.camel@shinybook.infradead.org>
 <CAN8TOE8Xf9fv9zyY6wof3b9QhqgV=s-cK4V4D6n+Gw4HgacT0g@mail.gmail.com>
Message-ID: <1380279555.28494.171.camel@i7.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-09-19 at 17:44 -0700, Brian Norris wrote:
> > Does that m25p80 'fix 4 byte addressing' fix for Micron not also want to
> > go in?
> 
> I suppose the m25p80 one can go in as well. It's not so much a bugfix
> as augmenting my original patch to support more devices. But it is
> safe enough.

You say 'support more devices', but AFAICT the code in -rc1 will already
*attempt* to enable 4-byte addressing on those devices, and fail.

(It looks like set_4byte() can return failure, but its return code isn't
checked, and anyway it's only a SPI write so there's no feedback from
the *chip* if it fails due to lack of WREN; it can only indicate failure
if the SPI connection falls over.)

So I'm inclined to think of it as a bug fix and include it.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6242 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130927/bdd29266/attachment.bin>
