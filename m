From: khilman@ti.com (Kevin Hilman)
Date: Wed, 29 Feb 2012 10:07:08 -0800
Subject: [PATCH 04/14] ARM: OMAP3+: SmartReflex: Add a shutdown hook
In-Reply-To: <CAOMWX4dbufbEJpr0nTmwTHR1xz9diMBbO=khKxvMZLWrKesJRw@mail.gmail.com>
 (Nishanth Menon's message of "Tue, 28 Feb 2012 16:59:14 -0600")
References: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
 <1328723039-15952-5-git-send-email-j-pihet@ti.com>
 <87d38yk2e1.fsf@ti.com>
 <CAOMWX4dbufbEJpr0nTmwTHR1xz9diMBbO=khKxvMZLWrKesJRw@mail.gmail.com>
Message-ID: <878vjlfr8z.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Menon, Nishanth" <nm@ti.com> writes:

> On Tue, Feb 28, 2012 at 16:40, Kevin Hilman <khilman@ti.com> wrote:
>> Jean Pihet <jean.pihet@newoldbits.com> writes:
>>
>>> From: Nishanth Menon <nm@ti.com>
>>>
>>> SmartReflex fix for erratum ID i724.
>>>
>>> Since OMAP's VP and PRM modules do not get reset by warm reset,
>>> we should ensure that proper shutdown procedure is followed prior
>>> to allowing the kernel to reboot back up.
>>
>> prior to reboot? ?how?
>>
>> This patch only ensures a proper shutdown if the kernel goes down
>> cleanly.
>>
>> How is this handled on reboot?
> There is no known solution for watchdog resets(part of the errata WA
> limitation) :( - the best we could do was to make shutdown path safe -
> this includes s/w (userspace triggered) reboots.

OK, then the changelog needs an update to reflect that.

Kevin
