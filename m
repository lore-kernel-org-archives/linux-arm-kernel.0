From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 21 May 2012 10:27:31 +0100
Subject: [PATCH] arm: Add basic support for new Marvell Armada SoC family
In-Reply-To: <20120521091615.GD14362@lunn.ch>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <alpine.LFD.2.02.1205161552490.1640@xanadu.home>
 <20120518191832.GC24238@titan.lakedaemon.net>
 <201205182044.26409.arnd@arndb.de> <4FBA030F.4050101@codethink.co.uk>
 <20120521091615.GD14362@lunn.ch>
Message-ID: <4FBA0A83.1030201@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/05/12 10:16, Andrew Lunn wrote:
> On Mon, May 21, 2012 at 09:55:43AM +0100, Ben Dooks wrote:
>> On 18/05/12 21:44, Arnd Bergmann wrote:
>>> On Friday 18 May 2012, Jason Cooper wrote:
>>>>>
>>>>> In this case, we have wildly different names referring to the same chip
>>>>> family, and "orion" is far from hinting that it also constitute the
>>>>> support for Kirkwood, Dove or (some not all) Armadas, unless you are
>>>>> familiar with some legacy Marvell products.  This is why in this case I
>>>>> think that a directory name change might be appropriate, especially if
>>>>> we're going to cause churn by moving things around already.
>>>>>
>>>>> I agree that mrvl_ebu_* is not pretty.  This could be mv_ebu_* or
>>>>> mvebu_*.  Unless someone has another logical identifier to suggest which
>>>>> would capture all that family of SOCs that came out of EBU in Marvell of
>>>>> course.
>>>>
>>>> I prefer mvebu_* ...  nice and concise.
>>>>
>>>
>>> On a related topic, any preferences on where we will put all the board
>>> files? I think it would be helpful to put them into a separate place from
>>> the main platform files, so e.g. have all *-setup.c files go to
>>> arch/arm/mach-mvebu/board/*.c instead of arch/arm/mach-mvebu/*-setup.c
>>
>> What board files?
>>
>> As I see it there are no current users and all additional kernel support
>> should simply use devicetree.
>
> There are currently 14 kirkwood boards, 21 orion5x, 2 dove and 5
> mv78xx0 boards. All would end up in the same directory as part of this
> rename/merge.

Personally, my view is leave it alone and just add a new machine
directory.

Pushing items around doesn't really help the amount of code in the
kernel, the organisation does not add more than a line or two to the
Makefiles.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
