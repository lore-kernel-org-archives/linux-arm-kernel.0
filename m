From: robdclark@gmail.com (Rob Clark)
Date: Wed, 9 Jul 2014 09:28:19 -0400
Subject: [GIT PULL] msm drm update for component changes
In-Reply-To: <20140709122645.GQ21766@n2100.arm.linux.org.uk>
References: <20140709093458.GA17540@rmk-PC.arm.linux.org.uk>
 <CAF6AEGv+hzSKuD2mRDbz-hqN1H09tW5C4a2EYuZ5sN44RABe8w@mail.gmail.com>
 <20140709122645.GQ21766@n2100.arm.linux.org.uk>
Message-ID: <CAF6AEGszBdYCrfb5q6Cpr26aaqivkjVjGi_7Mn+wL4EkHzX0Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 9, 2014 at 8:26 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jul 09, 2014 at 06:56:14AM -0400, Rob Clark wrote:
>> On Wed, Jul 9, 2014 at 5:34 AM, Russell King <rmk@arm.linux.org.uk> wrote:
>> > David,
>> >
>> > Please incorporate the latest msm drm update for component changes, which can be found at:
>> >
>> >   git://ftp.arm.linux.org.uk/~rmk/linux-arm.git component-for-drm
>> >
>> > with SHA1 84448288546d13d7e06fd6638fb78ddff559b399.
>> >
>> > This updates the MSM's DRM driver for the updates merged in Greg's
>> > driver-core tree, converting MSM to use the pre-declared array of
>> > matches rather than walking the device tree each time we try to bind.
>>
>> Hey Russell, do you want me to take this for my v3.17 pull req?  I
>> expect there will be some minor conflicts with the DT support I'm
>> working on at the moment.
>>
>> Or does this need to be applied together with the rest of the series?
>> In which case, maybe it should go first, and then I'd rebase msm-next
>> on top.
>
> The patch for MSM is dependent on the component changes, which have
> already been merged by Greg for the driver-core tree.  I don't have
> anything following this, so if you instead want to merge my
> component-for-driver branch (which is what Greg's pulled, which is a
> sub-set of this pull), and then add this patch on top of your
> development, that's fine too.

ok, it sounds like it is probably easiest for Dave to take your pull
req after drm-next picks up the driver-core updates?

anyways, if needed, I can coordinate with Dave about that.  Sounds
easiest if I rebase my stuff on top of that before sending my pull req
for 3.17.

> The only reason it's a pull request and not a single patch is to ensure
> that the previous component commits don't end up being duplicated with
> different commit IDs across several trees by being applied independently
> as patches (which can end up causing unnecessary git conflicts.)

sure, no prob about a pull-req.. just wanted to sort out what order
things get merged in

BR,
-R

> --
> FTTC broadband for 0.8mile line: now at 9.5Mbps down 400kbps up.
