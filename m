From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Fri, 10 Apr 2015 16:37:50 +0300
Subject: [PATCH 2/2] arm64: add KASan support
In-Reply-To: <8790947.ikOtIjWHkt@wuerfel>
References: <1427208544-8232-1-git-send-email-a.ryabinin@samsung.com>
 <3164609.kEhR8riVSV@wuerfel> <5527AA94.5080803@samsung.com>
 <8790947.ikOtIjWHkt@wuerfel>
Message-ID: <5527D22E.9090000@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2015 04:02 PM, Arnd Bergmann wrote:
> On Friday 10 April 2015 13:48:52 Andrey Ryabinin wrote:
>> On 04/09/2015 11:17 PM, Arnd Bergmann wrote:
>>> On Tuesday 24 March 2015 17:49:04 Andrey Ryabinin wrote:
>>>>  arch/arm64/mm/kasan_init.c           | 211 +++++++++++++++++++++++++++++++++++
>>>>
>>>
>>> Just one very high-level question: as this code is clearly derived from
>>> the x86 version and nontrivial, could we move most of it out of
>>> arch/{x86,arm64} into mm/kasan/init.c and have the rest in some header
>>> file?
>>>
>>
>> I think most of this could be moved out from arch code, but not everything.
>> E.g. kasan_init() function is too arch-specific.
> 
> Right, makes sense. So presumably, populate_zero_shadow could become a global
> function by another name, and possibly also handle registering the die
> handler, so you can call it from an architecture specific kasan_init() 
> function, right?
> 

Yep, you are right.

> 	Arnd
> 
