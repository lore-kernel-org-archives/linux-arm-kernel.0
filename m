From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 23 Oct 2012 13:29:48 +0100
Subject: [PATCH 2/2] Revert "spi/pl022: enable runtime PM"
In-Reply-To: <20121023114723.GU21164@n2100.arm.linux.org.uk>
References: <1349452272-4002-1-git-send-email-ulf.hansson@stericsson.com>
 <1349452272-4002-2-git-send-email-ulf.hansson@stericsson.com>
 <CAPDyKFqfE0u2CPzFKeHBE1LMtuetWabR94KuASPNhw4StDCfjw@mail.gmail.com>
 <20121023111019.GV4477@opensource.wolfsonmicro.com>
 <20121023111656.GT21164@n2100.arm.linux.org.uk>
 <20121023114130.GW4477@opensource.wolfsonmicro.com>
 <20121023114723.GU21164@n2100.arm.linux.org.uk>
Message-ID: <20121023122948.GY4477@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 12:47:23PM +0100, Russell King - ARM Linux wrote:
> On Tue, Oct 23, 2012 at 12:41:31PM +0100, Mark Brown wrote:

> > I have to say I had been under the impression that Linus' series that I
> > applied the other day dealt with all the outstanding stuff here; the
> > issues with this have been the awful changelogs and the overalapping
> > sets of patches.

> Given that Linus is the one who introduced the fuckups in the first place,
> and afaics Linus' series has not been posted anywhere I can see, and I
> have been through the issues and worked with Ulf to get them fixed, I find
> that to be down right insulting by you.

Linus' patches were all posted to spi-devel-general.  I can understand
why you wouldn't subscribe to it given that it's a sourceforge list and
hence full of spam but it is the list of record for SPI unfortunately.

> You received *BOTH* of Ulf's patches on the 5th October.  Both needed
> to be applied *TOGETHER* to reduce the window where things got worse
> before they got better.  But for some goddamned unknown reason you decided
> to only take the first but totally and utterly ignored the second.

Unfortunately Ulf's original posting of the patches didn't include any
analysis of the problems or explanation as to why the reverts were
needed.  Since I had no idea what the patches were supposed to do having
not been involved in whatever discussion of the bugs were I didn't apply
them then.

Ulf did repost with a slightly clarified changelog and I *suspect* that
the second patch just got fat fingered due to the multiple different
revisions of the series that were floating around.

> Well done, you've probably crapped this driver up again.  Way to go Mark.
> Now, tell us _exactly_ what patches you've applied to this driver.  Post
> them to this mailing list so we can see them, and see what state this
> driver is now in.

> IMHO, you're being a terrible "maintainer" here - and this is being shown
> by the need to get you to post all the patches you've currently queued up
> for this.

As one would expect all the patches that are currently sitting there for
the driver are in -next already; one of the nice things about -next is
that it does tend to help remove doubt about things like this.

You just pointed me at the discussion of the original issue that
happened prior to Ulf's revert posting; I now see what's going on, your
analysis is crystal clear [1].  I'm just generating the extra revert of
2fb30d (spi/pl022: enable runtime PM) which I'll squash down into the
existing revert and send to Linus tomorrow.

[1] http://lists.arm.linux.org.uk/lurker/message/20120927.152412.d281a899.en.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121023/7acb8549/attachment-0001.sig>
