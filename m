From: linux.amoon@gmail.com (Anand Moon)
Date: Wed, 8 Apr 2015 14:23:47 +0530
Subject: [PATCH 5/6] pwm: samsung: Fix output race on disabling
In-Reply-To: <1428482527.4333.50.camel@collabora.co.uk>
References: <1427387955-5129-1-git-send-email-linux.amoon@gmail.com>
 <1427387955-5129-6-git-send-email-linux.amoon@gmail.com>
 <20150408102811.219b964f@amdc2363>
 <1428482527.4333.50.camel@collabora.co.uk>
Message-ID: <CANAwSgQAWtpgy4hX8c=B2i5nhooJE8HxHj8L=gqu9QuZZrge6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sjoerd,

Correct. Will do so. I just included in this series. As it relevant to
my changes and testing.

-Anand Moon

On 8 April 2015 at 14:12, Sjoerd Simons <sjoerd.simons@collabora.co.uk> wrote:
>
>
> On Wed, 2015-04-08 at 10:28 +0200, Lukasz Majewski wrote:
>> Hi Anand,
>>
>> > From: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
>> > When disabling the samsung PWM the output state remains at the level
>> > it was in the end of a pwm cycle. In other words, calling pwm_disable
>> > when at 100% duty will keep the output active, while at all other
>> > setting the output will go/stay inactive. On top of that the samsung
>> > PWM settings are double-buffered, which means the new settings only
>> > get applied at the start of a new PWM cycle.
>
> This patch is already in the linux-pwm for-next tree so should probably
> be dropped form this patchset to prevent conflicts.
>
> --
> Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> Collabora Ltd.
