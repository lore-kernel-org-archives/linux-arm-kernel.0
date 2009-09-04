From: broonie@sirena.org.uk (Mark Brown)
Date: Fri, 4 Sep 2009 15:57:26 +0100
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <1b68c6790909040727j7b87fb9y71e89e9c99737bd@mail.gmail.com>
References: <20090902121158.GU32606@prithivi.gnumonks.org>
	<1b68c6790909020644k757827f4kf590779f384ceccb@mail.gmail.com>
	<20090902144700.GD4012@sirena.org.uk>
	<1b68c6790909021738o3037c9dcve6699a7b272f6742@mail.gmail.com>
	<20090903121410.GC2954@sirena.org.uk>
	<1b68c6790909030639i55b7f18dy6c2961a2830e4862@mail.gmail.com>
	<20090903151812.GE2954@sirena.org.uk>
	<1b68c6790909031808n5bb06987yfe06b3438b1d05b0@mail.gmail.com>
	<20090904134121.GB1576@sirena.org.uk>
	<1b68c6790909040727j7b87fb9y71e89e9c99737bd@mail.gmail.com>
Message-ID: <20090904145725.GC1576@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 04, 2009 at 11:27:48PM +0900, jassi brar wrote:

> I am afraid we are not able communicate our ideas clear enough, maybe
> b'coz am a bit slow
> or maybe i am wrong altogether. Let us communicate in code.

OK.  The bottom line in terms of this subthread is that all the user
should see in Kconfig is "Enable audio support for $BOARD" - if
something else is happening it at least needs to be explained in detail
why it's required.

> Btw, i am preparing patches against your sound-2.6 tree. Please tell
> if that is improper.

Yes, that's the right tree to work on.  Use the most recent for-2.6.x
branch for anything except bugfixes destined for Linus' tree - those
should go on the branch with the appropriate version number.

> AUDIO:-
>    As one of the maintainer of Samsung SoC audio part, please tell
> which task shud be my priority towards
> enabling better audio support for 6410(and other newer SoCs too) in mainline.

I would suggest that the best thing would be to focus on adding support
for the IISv4 and AC'97 controllers.  I'd suggest doing the AC'97
controller first since that is the one I've seen the most demand for
from users and it's a fairly static standalone block.  I already
submitted changes to add the platform devices for it which are IIRC in
Ben's tree and hit 2.6.32.

I can take care of the machine drivers (or the bulk of the work on
completing them) for you if you like - for the WM8580 I wanted to have a
look at modernising the driver while I was looking at this anyway which
will affect the machine drivers.
