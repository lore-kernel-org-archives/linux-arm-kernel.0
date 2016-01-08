From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 9 Jan 2016 01:06:55 +0900
Subject: range operation of outer cache when start >= end?
In-Reply-To: <20160108150618.GL19062@n2100.arm.linux.org.uk>
References: <CAK7LNATi5CE3Uc5UgQ6OncC5b=bDavAyNfqi_nqvcVkOrbFhRQ@mail.gmail.com>
 <20160108150618.GL19062@n2100.arm.linux.org.uk>
Message-ID: <CAK7LNARod6AVBC7KsPRieONgoRwVE-uhfGhJjtRyu6kHgFRYTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,


2016-01-09 0:06 GMT+09:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Fri, Jan 08, 2016 at 11:54:30AM +0900, Masahiro Yamada wrote:
>> I know I am nitpicking.  Forgive me if I am asking a silly question.
>>
>>
>> How should the outer-cache handle such an insane case like  start >= end?
>
> Passing start >= end isn't defined, code should not pass start >= end.
>
>> Assumed answers are:
>>
>> [1] Do not care about that.  It should never happen.  If it does, fix
>> the caller.
>
> This applies.  What situation are you seeing start >= end?

I never see such a case at all.
When I saw l2c210_inv_range(), I just wondered whether it should be
cared or not.


> What you will get with the existing code is potentially some cache
> cleaning and a sync, but nothing apart from that.  __l2c210_op_pa_range()
> becomes a no-op of start >= end.  However, that behaviour is not
> guaranteed.

Thanks for your explanation!

-- 
Best Regards
Masahiro Yamada
