From: holler@ahsoftware.de (Alexander Holler)
Date: Thu, 07 Apr 2011 01:22:27 +0200
Subject: [PATCH 1/2] ARM: Differentiate SheevaPlugs and DockStars on the
	basis of the memory size.
In-Reply-To: <alpine.LFD.2.00.1104061850410.28032@xanadu.home>
References: <1302122121-3652-1-git-send-email-holler@ahsoftware.de>
	<1302122121-3652-2-git-send-email-holler@ahsoftware.de>
	<alpine.LFD.2.00.1104061739100.28032@xanadu.home>
	<4D9CED15.2010806@ahsoftware.de>
	<alpine.LFD.2.00.1104061850410.28032@xanadu.home>
Message-ID: <4D9CF5B3.9020007@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.04.2011 01:01, Nicolas Pitre wrote:
> On Thu, 7 Apr 2011, Alexander Holler wrote:
>
>> On 06.04.2011 23:44, Nicolas Pitre wrote:
>>> On Wed, 6 Apr 2011, Alexander Holler wrote:
>>>
>>>> It is possible to differentiate a SheevaPlugs and DockStars on the basis
>>>> of the memory size.
>>>>
>>>> This makes it possible to unify both setup files.
>>>
>>> No no no !!!  This is an abomination!
>>>
>>> We are not going to reduce the amount of code under arch/arm/ with such
>>> fragile hacks.  This would create an even worse maintenance problem the
>>> day either of those devices is released with more RAM or whatever.
>>
>> DockStars are already obsolet and vanilla Linux was never supported by the
>> manufacturer (Seagate). And they never used the machine type in question.
>
> Is the code for DockStar in mainline actually useful?  If no then we may
> simply delete it.

I don't know, I can't speak for others.

>> So I don't think this in any way a fragile hack.
>
> Determining a machine type based on its amount of RAM is fragile, ugly
> and sets up a bad example for even more hacky tricks like this to crop
> up. If someone is experimenting with his SheevaPlug by giving different
> memory information in the kernel cmdline e.g. to create memory holes in
> order to test some memory allocator changes, then the kernel may think
> that it is not running on a SheevaPlug but a DockStar, and the resulting
> behavior will certainly be unexpected.

People doing such should now what they do. And the pr_info() in the 
"abomination" should be enough to give those experimenters a hint (if it 
is missing or new).

>> Anyway, it was just a suggestion.
>
> Better luck next time.

Sorry, I don't feel the need to waste my time prodcuing patches to get 
them called "abominations". Which means my willingness to post further 
patches just got below zero.

Regards,

Alexander
