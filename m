From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 6 Sep 2011 00:09:56 +0300
Subject: [PATCH 1/2] ux500: Adding support for u8500 Hsem functionality V2
In-Reply-To: <201104191810.18170.arnd@arndb.de>
References: <1302535464-12294-1-git-send-email-mathieu.poirier@linaro.org>
	<201104172239.57362.arnd@arndb.de> <4DADB2F1.1080405@linaro.org>
	<201104191810.18170.arnd@arndb.de>
Message-ID: <CAK=WgbZVuw3ERa+sbm+RwdBL+JrxmZwpQtjk3mBvtUZVbiNu6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

On Tue, Apr 19, 2011 at 7:10 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 19 April 2011, Mathieu Poirier wrote:
>> > One more thing I just noticed: the hwspinlock_internal.h file defines
>> > the hwspinlock->id field as "a global, unique, system-wide, index of
>> > the lock", but the u8500 hsem just sets it to an integer starting
>> > at zero. If there are multiple devices providing hwspinlocks in the
>> > same system, that cannot work.
>> >
>> I have to admit I'm not sure of what your asking here. ?Hwspinlocks
>> should be administered by only one entity and this is what this driver
>> is doing.
>>
>> Please get back to me with a clarification.
>
> You could have a system with multiple instances of the hardware block
> that holds your spinlock. I've seen SMP systems that basically take
> multiple SOCs and put them into a common address space.
>
> More importantly, there could be a device on an external bus that also
> provides a hwspinlock. The API can deal with this, but your driver will
> conflict with any other driver trying to do the same.

Looks like this thread has died. Is this driver still needed ?

If yes, I don't mind picking it up and fixing the outstanding issues,
as I'm doing some hwspinlock cleanups/fixes right now anyway.

Regards,
Ohad.
