From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 11 Nov 2012 19:47:46 +0100
Subject: [PATCH 0/2] clk: ux500: Make mtu driver use apb_pclock
In-Reply-To: <20121110012449.16569.82732@nucleus>
References: <1351080821-18660-1-git-send-email-ulf.hansson@stericsson.com>
 <CACRpkdb3dcDhVD5qkOrRkLJ-RXdmqJ2tAkosoeEB_DwSDSShKw@mail.gmail.com>
 <20121110012449.16569.82732@nucleus>
Message-ID: <CACRpkdbGnvywcQWRN9v_=1nkmaqgJK92Zs1S5HSLgppa49bQqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2012 at 2:24 AM, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Linus Walleij (2012-10-24 10:25:26)
>> On Wed, Oct 24, 2012 at 2:13 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
>>
>> > From: Ulf Hansson <ulf.hansson@linaro.org>
>> >
>> > The apb clock was before the "common" clock driver for ux500 was merged,
>> > handled internally by the clock driver. Now this clock needs to be managed
>> > from the mtu driver as a separate clock.
>> >
>> > This patches is based in 3.7 rc2.
>> >
>> > It is important the "ARM nomadik patch" is merged together with the
>> > clock patch to not break boot. Therefore I suggest this series to go
>> > through Mike Turquettes clock tree.
>>
>> OK go ahead:
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> I've taken these into clk-next.  While the patches are trivial I'd still
> prefer a changelog in the future.  For instance, it would be nice to
> explain why removing the block comment is OK in the first patch.

So there may be some collision in linux-next due to this,
because I've moved the nomadik timer to
drivers/clksrc and deleted the entire plat-nomadik
directory.

I don't know quite how ingenious git is in detecting
patches on moved files, but if it's causing trouble
I think it's better if you could ACK them and we
could reubmit them to ARM SoC on the multiplatform
branch. i.e. this one:
http://git.kernel.org/?p=linux/kernel/git/arm/arm-soc.git;a=shortlog;h=refs/heads/next/multiplatform

Yours,
Linus Walleij
