From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 19 Feb 2016 11:57:45 +0200
Subject: [PATCH v3 05/10] serial: mps2-uart: add support for early console
In-Reply-To: <56C6E42E.5070601@arm.com>
References: <1455617295-23736-1-git-send-email-vladimir.murzin@arm.com>
 <1455617295-23736-6-git-send-email-vladimir.murzin@arm.com>
 <CAHp75VdugAq0WnzLHmd9CJHCjBOdBwPqCmC3ARSaVF5XMYGoMw@mail.gmail.com>
 <56C31F9F.10000@arm.com> <56C6E42E.5070601@arm.com>
Message-ID: <CAHp75VcosaVcz_aYbpfL-nUH0kBf72SshXU5k95s48Z3wnA5nQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 11:45 AM, Vladimir Murzin
<vladimir.murzin@arm.com> wrote:
> On 16/02/16 13:09, Vladimir Murzin wrote:
>>>> +EARLYCON_DECLARE(mps2, mps2_early_console_setup);
>>>> >> +OF_EARLYCON_DECLARE(mps2, "arm,mps2-uart", mps2_early_console_setup);
>>> >
>>> > IIRC Peter Hurley mentioned you don't need to put both anymore, OF_
>>> > one is enough.
>>> >
>> I've just tried with OF_ only and seems it works fine. Thanks for
>> pointing at it!
>>
>
> ..and the reason for that was that I had stdout pointing at uart node.
> Now, while testing v4 I end-up with configuration:
>
> 1) no EARLYCON_DECLARE in mps2-uart.c
> 2) stdout not set
> 3) cmdline has "earlycon=mps2,0x40004000 console=/dev/ttyMPS"
>
> and I don't see bootconsole, but if I avoid 1) everything works fine.
> So, I'd leave EARLYCON_DECLARE in this patch.

Peter, what is your comment on this?


-- 
With Best Regards,
Andy Shevchenko
