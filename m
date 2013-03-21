From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Mar 2013 18:10:33 +0100
Subject: [PATCH 4/6] mfd: db8500-prcmu: get base address from resource
In-Reply-To: <1669538.W5XG4BgH9e@wuerfel>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
 <1363866553-15054-5-git-send-email-linus.walleij@stericsson.com>
 <1669538.W5XG4BgH9e@wuerfel>
Message-ID: <CACRpkdZhyWdwhYaD69n=US31eTA=FDm6xzbZJndBuXAO0qGUbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 1:15 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> On Thursday 21 March 2013 12:49:11 Linus Walleij wrote:
>> -#define PRCM_PLLARM_LOCKP       (_PRCMU_BASE + 0x0a8)
>> +#define PRCM_PLLARM_LOCKP       (prcmu_base + 0x0a8)
>>  #define PRCM_PLLARM_LOCKP_PRCM_PLLARM_LOCKP3   0x2
>
> While this is certainly the least invasive way to get rid of _PRCMU_BASE,
> it sucks to refer to local variables in macros. How hard would it
> be to find all users of these macros and put the prcmu_base addition
> there?
>
> The rest of this patch looks fine to me.

Basically I didn't want to disturb Lo?cs work on PRCMU refactoring,
but if it is require I can surely do this.

Lo?c, are you OK with this?

Yours,
Linus Walleij
