From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 17 Dec 2015 09:48:57 +0100
Subject: [PATCH v2 0/8] Raspberry Pi 2 support.
In-Reply-To: <874mfhsyem.fsf@eliezer.anholt.net>
References: <1450310115-22163-1-git-send-email-eric@anholt.net>
 <21040591.KakM5Gl6ZZ@wuerfel> <874mfhsyem.fsf@eliezer.anholt.net>
Message-ID: <567276F9.5070903@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 17.12.2015 um 01:37 schrieb Eric Anholt:
> Arnd Bergmann <arnd@arndb.de> writes:
>
>> On Wednesday 16 December 2015 15:55:07 Eric Anholt wrote:
>>> This is a major rewrite of the previous Raspberry Pi 2 submission.
>>> SMP support is now included, and the DT includes are cleaned up to
>>> avoid massive duplication.
>>>
>>> The branch (based on 4.4-rc5, to get the USB regression fixes) can be
>>> found at:
>>>
>>> https://github.com/anholt/linux/tree/bcm2836-4.4
>> Looks all good to me, but when we get the pull request, I'd strongly
>> prefer to have that based on -rc3 or earlier.
>>
>> What commit is the USB regression fix you refer to above? Is that in a
>> branch that is -rc3 based? Maybe you can rebase the changes on top
>> of that branch, to minimize the amount of backmerges?
> Top 4 commits of drivers/usb/dwc2 for 4.4-rc5 (possibly not all of them
> are required, but it's what I've been using).  
>

Unfortunately all 4 of them are required:

d0464bcf12af ("usb: dwc2: Make PHY optional")

6c2dad69163f ("usb: dwc2: Return errors from PHY")

8aa90cf2a286 ("usb: dwc2: make otg clk optional")

f74875dc3613 ("usb: dwc2: fix kernel oops during driver probe")

But they should apply to -rc3 too.

Stefan
