From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Dec 2012 01:43:47 +0100
Subject: [PATCH] ARM: VIC: use irq_domain_add_simple()
In-Reply-To: <CACRpkdbtn4Pz3uLCxDGOBSVW7vfLECf2UZkT5+X9ip1ZZFb8Lw@mail.gmail.com>
References: <1350392786-29191-1-git-send-email-linus.walleij@stericsson.com>
 <507D61E7.2080704@gmail.com>
 <CACxGe6tBLfj3CDDZAfGmznj3B-h4OfJsrRc+85w9fnxFH6Cd_Q@mail.gmail.com>
 <CACRpkdbtn4Pz3uLCxDGOBSVW7vfLECf2UZkT5+X9ip1ZZFb8Lw@mail.gmail.com>
Message-ID: <CACRpkdb=neoRkCmTVyrAoiP4JTU4GqEZG727JAU6J_bot+DSqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 20, 2012 at 7:45 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Dec 19, 2012 at 12:34 AM, Grant Likely
> <grant.likely@secretlab.ca> wrote:
>
>> It looks to me like the below patch breaks versatile because it makes
>> it try to register a linear irq_domain instead of the legacy one that
>> it needs. Here are the relevant commits:
>>
>> 07c9249f1: "ARM: 7554/1: VIC: use irq_domain_add_simple()"
>> 946c59a08: "ARM: vic: fix build warning caused by previous commit"
>>
>> I'm working on getting it properly sorted out (and more importantly
>> *simplified*), but in the mean time I think the above two commits need
>> to be reverted. Reverting them on my tree fixes booting for me.
>
> Isn't that a bit violent, can't we just fix the real bug?
>
> Does the below patch work for you, it does two things:

I've submitted the fixes to Russell's patch tracker now ... would
appreciate some testing but I'm pretty sure they will fix the issue.

Yours,
Linus Walleij
