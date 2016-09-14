From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Sep 2016 18:36:26 +0100
Subject: [GIT PULL] Greybus driver subsystem for 4.9-rc1
In-Reply-To: <20160914100949.GA6179@kroah.com>
References: <20160914100949.GA6179@kroah.com>
Message-ID: <20160914173625.GB15356@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On Wed, Sep 14, 2016 at 12:09:49PM +0200, Greg KH wrote:
> Given that it's never a good idea to keep subsystems out of the mainline
> kernel, I've put together this pull request that adds the greybus driver
> layer to drivers/greybus/.  Because this was 2 1/2 years of work, with
> many many developers contributing, I didn't want to flatten all of their
> effort into a few small patches, as that wouldn't be very fair.  So I've
> built a git tree with all of the changes going back to the first commit,
> and merged it into the kernel tree, just like btrfs was merged into the
> kernel.

> Unless people point out some major problems with this, I'd like to get
> it merged into 4.9-rc1.

I'm extremely concerned that these patches have *never* seen upstream
review, and this pull request gives no real opportunity for people to
make a judgement regarding the code, as many relevant parties have not
been Cc'd.

>From a quick scan of the git tree, I can see code (that isn't even
placed under staging/) for which I have fundamental objections to as a
maintainer, and has not been Cc'd to a relevant list.

For example, I see commit 5a450477311fbfe2 ("greybus: timesync: Add
timesync core driver"). This states that it directly accesses the ARMv7
architected timer, though it's unclear as to precisely what it's doing
since it introduces an (undocumented) compatible string, and what should
be an unnecessary devicetree property.

That's never gone to the linux-arm-kernel mainline list, myself or Marc
(as maintainers of the arch timer driver), nor has the binding seen any
review on the devicetree mailing list.

Given that, for at least that patch, NAK.

Thanks,
Mark.
