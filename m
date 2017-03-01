From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 1 Mar 2017 18:43:13 +0000
Subject: [PATCH v3 11/25] ARM: dts: Add Actions Semi S500 and LeMaker
 Guitar
In-Reply-To: <11053e03-8e28-e93d-f1f6-2589a9f7800c@suse.de>
References: <20170228063535.32069-1-afaerber@suse.de>
 <20170228063535.32069-12-afaerber@suse.de>
 <20170228123245.GF3691@leverpostej>
 <11053e03-8e28-e93d-f1f6-2589a9f7800c@suse.de>
Message-ID: <20170301184313.GO28874@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2017 at 04:13:00PM +0100, Andreas F?rber wrote:
> Am 28.02.2017 um 13:32 schrieb Mark Rutland:
> > On Tue, Feb 28, 2017 at 07:35:21AM +0100, Andreas F?rber wrote:

> >> +#include "skeleton.dtsi"
> > 
> > Please don't include skeleton.dtsi.
> 
> Wasn't aware that was permissible. I now see it has been updated with a
> textual comment, which predates my past uses of skeleton.dtsi - for
> other pending work such as FM4 and XMC4500 I only noticed it was moved
> out of armv7m.dtsi so that dtc started spewing scary messages. ;)
> 
> A #warning might be a more effective way to make people aware of its
> deprecation - but sadly we have users that predate #include:
> 
> $ git grep /include/ -- arch/arm/boot/dts/ | grep skeleton.dtsi | wc --lines
> 32
> $ git grep /include/ -- arch/arm/boot/dts/ | grep skeleton64.dtsi | wc
> --lines
> 0
> $ git grep skeleton -- arch/arm/boot/dts/ | wc --lines
> 117

I deliberately didn't go that route, since people would blindly fix up
the warning and mess it up (e.g. forgetting to add the required nodes).

While it should be avoided for new dts, it's largely not problematic for
old dts, and we can fix those up at our leisure.

> > Please add the relevant nodes and
> > properties explciitly to your dts{i,} files.
> 
> Great, will do.
> 
> But this series has grown too large to resend just for such nits. Is
> there a chance we can get initial patches queued on some arm-soc
> for-next branch soonish? It seems -rc1 pulls were merged 5 days ago?

There seem to be other comments on this series, and I was under the
impression that arm-soc generally pulled branches.

Even if you're not going to repost, surely you can fold in the fixup
before sending the pull request?

Thanks,
Mark.
