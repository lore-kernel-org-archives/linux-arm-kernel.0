From: olof@lixom.net (Olof Johansson)
Date: Wed, 23 Feb 2011 13:51:43 -0800
Subject: [PATCH 5/5] ARM: Tegra: Enable Harmony audio support
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF03112A5D95@HQMAIL01.nvidia.com>
References: <1298487532-5000-1-git-send-email-swarren@nvidia.com>
	<1298487532-5000-6-git-send-email-swarren@nvidia.com>
	<AANLkTimffVNK2EmTqypQcrWHLisf3c8_dMsHwSbv-nWi@mail.gmail.com>
	<AANLkTi=tDJvfEFFvXGEkZswRWekRLuz4rBoT-0hgobgn@mail.gmail.com>
	<AANLkTinzVinbW_rDt5Rqe7i68P2u_XvDvRWA8R2mq0_9@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF03112A5D95@HQMAIL01.nvidia.com>
Message-ID: <AANLkTikmP5H6TQN1v1BNbGTfGokHgyXQ5LbFpEWgWjPB@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 23, 2011 at 1:35 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Olof Johansson wrote at Wednesday, February 23, 2011 2:25 PM:
>> On Wed, Feb 23, 2011 at 1:21 PM, Colin Cross <ccross@android.com> wrote:
>> > On Wed, Feb 23, 2011 at 1:08 PM, Olof Johansson <olof@lixom.net> wrote:
>> >> Stephen,
>> >>
>> >> Since this depends on i2c, and registers one of the adapters to do it,
>> >> we should just get the adapters registered separately (all of them)
>> >> before this. I was holding off that part of board code since the i2c
>> >> driver went up that maintainer path instead, but if Colin pulls it
>> >> into tegra for-next, then I'll go ahead with those peices as well.
>> >
>> > I'll merge the i2c-tegra branch into for-next (assuming Ben doesn't
>> > object to it), and you can put all the i2c devices in your pull
>> > request. ?That way we can get everything except this patch into the
>> > first pull request to Linus, and just put this patch into a second
>> > pull request once the ASoC branch is merged.
>>
>> Sure, that works. I'll stage the i2c changes tonight.
>
> OK, so just so I'm clear:
>
> Patches 1..4 are all going in as-is.
>
> I should re-post patch 5 once the merge window is open, having rebased
> it on Olof's i2c registration changes, and
> s/GPIO_WM8903/HARMONY_GPIO_WM8903/. Or, should I repost as soon as Olof
> has updated his branch with the I2C changes, and you'll just hold off
> applying it until the merge window?

How big would the delta be between a patch that would apply (and work)
with current .38-rc wm8903 platform data? If it's just the GPIO base,
we can merge everything but that and just do the small change late in
the merge window.

And yeah, please repost after the i2c stuff is in my branch, I'll
stage it accordingly.


-Olof
