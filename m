From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 17 Sep 2014 23:06:42 +0200
Subject: Cortex-M and zImage
In-Reply-To: <20140917070509.GN3755@pengutronix.de>
References: <CAGhQ9VzzSq4P5BKM3UBBCPT61g3T1RHFhttfA-KkWGCcrjaW6A@mail.gmail.com>
 <20140917061110.GM3755@pengutronix.de>
 <CAGhQ9VyhXywQ2kBKK9K5McQf153qXzgsPzt3GoCCL=QjWR2ogw@mail.gmail.com>
 <20140917070509.GN3755@pengutronix.de>
Message-ID: <CAGhQ9VwR+UWsRDgR9c=aPxuZRQkG==bCRZcis6WXKBpc5j=NwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 September 2014 09:05, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> Hello Joachim,
>
> On Wed, Sep 17, 2014 at 08:55:05AM +0200, Joachim Eastwood wrote:
>> On 17 September 2014 08:11, Uwe Kleine-K?nig
>> <u.kleine-koenig@pengutronix.de> wrote:
>> > I was able to compile a zImage with the patch below. For the
>> > "Conflicting architecture profiles" error the most relevant hunk is the
>> > first. And of course this needs some #ifdefs.
>>
>> Thanks, I'll give it a try later today.
>>
>> But is this the way to go?
>> Adding lots of 'ifdefs CONFIG_CPU_V7M' to compressed/head.S ?
> Probably not lots. I would expect (and hope) that you won't need more
> than a handful. I don't see an alternative.

Okey, I got it working.

Had to add a total of 6 ifdefs to compressed/head.S so I guess it is
not too bad.

Here is the diffstat:
arch/arm/boot/compressed/head.S | 17 +++++++++++++++++
1 file changed, 17 insertions(+)

I'll send out a patch for comments tomorrow.

regards
Joachim Eastwood
