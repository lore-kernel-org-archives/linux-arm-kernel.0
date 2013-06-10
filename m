From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Jun 2013 12:54:51 +0200
Subject: [PATCH 2/4] mfd: dbx500-prcmu: Correctly reorder PRCMU clock
 identifiers
In-Reply-To: <20130607142020.GB24958@gmail.com>
References: <1370517676-10909-1-git-send-email-lee.jones@linaro.org>
 <1370517676-10909-3-git-send-email-lee.jones@linaro.org>
 <CACRpkdYLB-_JjEd69vVub_Z3L+avQRrFBt1fGuyR0D_owcLWvA@mail.gmail.com>
 <20130607142020.GB24958@gmail.com>
Message-ID: <CACRpkdZiRZj05Wd3YKJO5hzXOMVJ0qESANEa=8LCGR=tn2AK7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 7, 2013 at 4:20 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Fri, 07 Jun 2013, Linus Walleij wrote:
>
>> > -enum prcmu_clock {
>> > -       PRCMU_SGACLK,
>> (...)
>> > +#define ARMCLK                 0
>> > +#define PRCMU_ACLK             1
>> (...)
>>
>> It seems the enum and the defines want to do two different things?
>>
>> The first is a kernel-internal representation of the clocks, whereas
>> the latter is a HW-centric representation for a certain PRCMU
>> variant (I guess?)
>>
>> Does one actually exclude the other?
>
> From what I can tell, they're non-ordered values which are used as
> read-ins to the clk_mgt array. So long as they are unique I'm not sure
> the order matters. The current order seems 'made up', unless I'm
> mistaken.

Hm, I suspect it might be something to do with the enumeration
inside the PRCMU firmware, but I don't really know. In that case it
could affect the message marshalling, but let's call out the experts...

Yours,
Linus Walleij
