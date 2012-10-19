From: dromede@gmail.com (=?UTF-8?B?TWFya28gS2F0acSH?=)
Date: Fri, 19 Oct 2012 13:37:25 +0200
Subject: pxa:spitz_pm.c: commit b6eede11 breaks spitz resume under certain
 conditions.
In-Reply-To: <CAHod+GcwNr6r_ZQFq-btPJ3E_keWKJhkCb2jP4CES6JTSyn8ow@mail.gmail.com>
References: <CAHod+GeMyc+5ERmzY4CYp3SJK-6LOQrhLrLiXSuV3Pdr8+UzSg@mail.gmail.com>
 <CAMPhdO-6iWUWm=vTp-e25BkYBuM5kQfxNW57xKNtKDRU-5Ymgw@mail.gmail.com>
 <CAHod+Gc1L0pPZhnPL6Q2rx0KT=-VqdWaTd1FJt2aA9hTMZyeDg@mail.gmail.com>
 <CAMPhdO8duNqisVL+FLc_0zgFTP+13r83XtRD0YbpdkzMuJov3Q@mail.gmail.com>
 <CAHod+Gd=aLbntWsX_S_26_XSUtG9DQYkki1Y+drq0+8GdnHfaw@mail.gmail.com>
 <CAHod+GcwNr6r_ZQFq-btPJ3E_keWKJhkCb2jP4CES6JTSyn8ow@mail.gmail.com>
Message-ID: <CAHod+GfycPnugk0UF6aqFUb4UJwZRM_PHPiSDpGSbF3OXSwMLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2012 at 11:28 AM, Marko Kati? <dromede@gmail.com> wrote:
>> Almost there, but I guess we could do this better and less confusing by having
>> another array, e.g. tosa_gpio18_config[], which is tosa specific, and only
>> initialize that MFP setting in the tosa path.
>>
>>>
>>> I also looked at the original sharp kernel sources.
>>> Only tosa used the RDY signal for it's tc6393tx chip, other machines simply
>>> configured gpio18 as output in their suspend routines.
>
>
> Actually, tosa doesn't use sharpsl_pm. Tosa uses the pda-power framework.
> I said that only tosa uses the RDY signal to point out that we
> probably don't need
> the mfp-config line in postsuspend. That being said, i still think
> that the array ordering
> fix is adequate. Maybe later we may remove the mfp-config line from
> postsuspend when
> we're absolutely sure it isn't necessary for devices that use spitz_pm.c.

So Eric what do you think, is the simple gpio array reordering patch
an adequate fix for this bug?
