From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 13 Feb 2014 14:24:01 +0100
Subject: [PATCH v3 01/13] ARM: mvebu: rename armada-370-xp.c to
 armada-mvebu.c
In-Reply-To: <20140213141355.00e8f2fd@skate>
References: <1392289475-8902-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392289475-8902-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <2036226.egxWL7qC66@wuerfel> <20140213125526.3af08c54@skate>
 <20140213130745.GU27395@titan.lakedaemon.net> <20140213141355.00e8f2fd@skate>
Message-ID: <52FCC771.5090009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/14 14:13, Thomas Petazzoni wrote:
> On Thu, 13 Feb 2014 08:07:45 -0500, Jason Cooper wrote:
>>>> Your reasoning for the new name makes a lot of sense, but my personal
>>>> opinion is that I'd rather leave the name as it is and deal with the
>>>> fact that it's not the best name. Renaming files often causes unexpected
>>>> problems, in particular if someone else wants to modify the same file.
>>>
>>> I believe it's a matter of taste here. Having a file named
>>> armada-370-xp.c that handles Armada 375 and Armada 38x looks highly
>>> confusing to me, and I believe both Gr?gory and Ezequiel were of the
>>> same opinion.
>>>
>>> The number of changes to this file is very limited, so the probability
>>> of having a large number of complicated patches touching the same file
>>> being in flight is fairly low.
>>>
>>> Maybe we can leave this taste decision to the mach-mvebu maintainers?
>>
>> board-v7.c and then board-v5.c ?
>
> Why not. But since this kind of change can be done without breaking the
> DT compatibility, I'd first prefer to see Dove support merged into
> mach-mvebu/ with its board file named mach-mvebu/dove.c. Then
> progressively see what can be combined with armada-mvebu.c so that we
> can merge both of them into board-v7.c.

Actually, just prepared those patches today. Haven't boot tested but
compiles cleanly. The patch set will be really small compared to KW
patch set (but de-hardcoded pinctrl-dove will be a prerequisite).

I also prefer to move to mach-mvebu/dove.c and then merge with
armada-3{78}{05x} a cycle later.

Sebastian
