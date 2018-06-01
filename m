From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 1 Jun 2018 14:04:03 +0300
Subject: [PATCH 0/4] lib/vsprintf: Remove atomic-unsafe support for printk
 format %pCr
In-Reply-To: <CA+55aFxHHSRnDbbNGq6SwNAwEt0EhX15n_pNqon3MzGYJgMJmA@mail.gmail.com>
References: <1527845302-12159-1-git-send-email-geert+renesas@glider.be>
 <CA+55aFxHHSRnDbbNGq6SwNAwEt0EhX15n_pNqon3MzGYJgMJmA@mail.gmail.com>
Message-ID: <CAHp75VeCmeBkUfnmx2F-czHCVVDm32WiGzvih8xozPEdv8P_Hw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 1, 2018 at 2:00 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Jun 1, 2018 at 4:29 AM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>>
>> This patch series:
>>   - Changes all existing users of "%pCr" to print the result of
>>     clk_get_rate() directly, which is safe as they all do this in task
>>     context only,
>>   - Removes support for the "%pCr" printk format.
>
> Looks good to me.
>
> What tree will this go through? The normal printk one? Just checking
> that this doesn't end up falling through the cracks because nobody
> knows who would take it...

We discussed few month before with Petr that he would take care of the
patches against vsprintf.c.
I think this is the case here.

-- 
With Best Regards,
Andy Shevchenko
