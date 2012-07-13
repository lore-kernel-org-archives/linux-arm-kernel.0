From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 13 Jul 2012 13:36:59 -0600
Subject: [PATCH 00/11] make struct of_device_id.data const
In-Reply-To: <5000175E.4070702@gmail.com>
References: <5000175E.4070702@gmail.com>
Message-ID: <CACxGe6tXvz+rt2yrHHaD=j94-=JQEh06sHW0FWGiHb2=9GS2pA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2012 at 6:41 AM, Rob Herring <robherring2@gmail.com> wrote:
> On 07/13/2012 07:32 AM, y at pengutronix.de wrote:
>> From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>>
>> Hello,
>>
>> this series' goal is to make struct of_device_id.data const.
>> Conceptually a driver must not modify the data contained there so making
>> it const is the right thing.
>>
>> This change might introduce warnings because drivers don't use const to
>> access the data pointed to by of_device_id.data. In most cases the fix
>> is to add some consts.
>>
>> This series (apart from adding this const in patch 10) fixes all drivers
>> covered by all arm defconfigs (based on v3.5-rc6).
>>
>
> What about other arches?

This whole series is of questionable value to me.  While I agree that
.data should be const, I don't think changing it has is measurably
better than what we have now.  Particularly when the series isn't
complete for all users.  And "building all defconfigs" is not the
right way to look for affected users.

g.
