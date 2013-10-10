From: sre@ring0.de (Sebastian Reichel)
Date: Thu, 10 Oct 2013 22:02:36 +0200
Subject: [RFCv3 0/7] OMAP SSI driver
In-Reply-To: <20131010182801.GB29989@blackmetal.musicnaut.iki.fi>
References: <1381091235-18293-1-git-send-email-sre@debian.org>
 <20131008172815.GA8313@atomide.com>
 <20131010172128.GF28657@earth.universe>
 <20131010182801.GB29989@blackmetal.musicnaut.iki.fi>
Message-ID: <20131010200236.GA6603@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 10, 2013 at 09:28:01PM +0300, Aaro Koskinen wrote:
> On Thu, Oct 10, 2013 at 07:21:30PM +0200, Sebastian Reichel wrote:
> > Any issues with this or any other suggestions how to proceed?
> 
> Maybe you could provide some brief instructions/description of how this
> was tested?

Sure. I used Carlos' original patch, which has been tested to be
working. Then I checked with some debug prints and the debugfs
support what the registers and resources should look like.
Next I updated the patch to use the new kernel frameworks and
made sure everything is behaves as before.

For actually using the modem of the Nokia N900 three more drivers
are needed in the mainline kernel in addtion to this one:

1. cmt

 This is a small driver handling the modem's reset line, which
 is connected via a gpio pin to the system.

2. ssi_protocol
 
 This is an hsi client driver, which actually talks with the modem
 and exports an phonet interface for userspace access. It makes
 use of the cmt driver.

 I plan on porting these to the new kernel frameworks next. If
 I'm not mistaken this should be enough to communicate with the
 modem.

3. cmt_speech

 This is an hsi client driver, which takes care of interchanging
 speech data with the modem. This one is needed for calling. I
 will have a look at it once the basic stuff is working.

P.S.: You can get a mainline kernel status matrix for the Nokia
      N900 on this page: http://elinux.org/N900

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131010/c6047523/attachment-0001.sig>
