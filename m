From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 21 Feb 2017 01:54:37 +0200
Subject: [PATCH v2 1/3] mtd: nand: Cleanup/rework the atmel_nand driver
In-Reply-To: <CAHp75VczsC9WdZWR9iCRh2JoNLFZyOtodrsDRYQoyaN7nkyf=A@mail.gmail.com>
References: <1487593718-20752-1-git-send-email-boris.brezillon@free-electrons.com>
 <1487593718-20752-2-git-send-email-boris.brezillon@free-electrons.com>
 <CAHp75VdwQGP-qa0c0KQwrdpZmCGc3RuEsJ-E-XLbBzQSn4Yxcg@mail.gmail.com>
 <20170220213803.7ba5591e@bbrezillon> <20170220215009.0ecbf5a1@bbrezillon>
 <CAHp75VczsC9WdZWR9iCRh2JoNLFZyOtodrsDRYQoyaN7nkyf=A@mail.gmail.com>
Message-ID: <CAHp75Vc_q-bEzA2-hVpHyR0GZ8mXxwJ8-UjECe31T04mb67q4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2017 at 1:40 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Feb 20, 2017 at 10:50 PM, Boris Brezillon
> <boris.brezillon@free-electrons.com> wrote:
>> On Mon, 20 Feb 2017 21:38:03 +0100
>> Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
>>
>>> On Mon, 20 Feb 2017 22:27:17 +0200
>>> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>>
>>> > On Mon, Feb 20, 2017 at 2:28 PM, Boris Brezillon
>>> > <boris.brezillon@free-electrons.com> wrote:
>>> >
>>> > >  drivers/mtd/nand/atmel/nand-controller.c | 2269 +++++++++++++++++++++++++++
>>> > >  drivers/mtd/nand/atmel_nand.c            | 2479 ------------------------------
>>> >
>>> > Does -M -C help you?
>>> > At least it would help reviewers
>>> >
>>>
>>> No it doesn't, because files were not just moved around using git mv,
>>> it's a complete rewrite of the driver. IIUC, you're about to review
>>> this submission, or are you just trolling like last time?
>>
>> My bad, I mistaken you with someone else. Sorry for being harsh, but my
>> explanation stands ;-).
>
> No problem. I was asking since it so big and on first glance looks
> like a partial copy (I dunno if parameter to -C makes it somehow
> useful), though I can't review this. It's too big to me. Sorry I'm
> really not trolling, just didn't read commit message carefully.

Okay, I very quickly looked into the code, what I noticed
- you like extra parens and empty lines in some cases (not big deal)
- some functions perhaps might have been refactored to have common
pieces in error handling, though I didn't read core carefully.

Most important part I have noticed is a GPIO request.
I didn't get why you almost repeat gpiod_get() in case of platform data?
Shouldn't we have GPIO look up table?
Can we use builtin device properties (for GPIO and/or overall)?


-- 
With Best Regards,
Andy Shevchenko
