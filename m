From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Jan 2013 13:55:33 +0100
Subject: [PATCH v7 09/15] gpio: pl061: set initcall level to module init
In-Reply-To: <20130122104107.GJ23505@n2100.arm.linux.org.uk>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
 <1358494279-16503-10-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdb=vf5s-XmfYYn5W-BjeNaf9vw6-sDSH6VDC41PBX0rdQ@mail.gmail.com>
 <1358785488.6590.33.camel@hornet>
 <CACRpkdY4MHLjs1Lnj+8Ts6oZOjG14pDssCQ09PX-a_5nGRs1sg@mail.gmail.com>
 <20130122104107.GJ23505@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdZfntdciJfNjX2vYPsNQTm+nxOPpSv4tvu=HMAYE74NvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 11:41 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jan 22, 2013 at 10:42:11AM +0100, Linus Walleij wrote:
>> On Mon, Jan 21, 2013 at 5:24 PM, Pawel Moll <pawel.moll@arm.com> wrote:
>>
>> > Hm. Doesn't this make the MMCI probing depending on the module_init
>> > order? As in: wouldn't it make the mmci probe completely fail (not even
>> > defer it) if it was called before the pl061? In that case even your,
>> > Linus, hack with inverting the CD status wouldn't work...
>>
>> According to Haojian it works, but for sure the MMCI driver *should*
>> (on the eternal list of SHOULDDO) bail out and return any
>
> Rather than talking about what should and should not, why not look at
> the code - it only takes a few moments to check what the behaviour
> would be.  And it is correct - errors are correctly propagated out of
> the probe function.

OK good!

> That's hardly surprising given who's supposed to be the maintainer of
> that driver.

Aouh that hurt! ;-)

Thanks Russell,
Linus Walleij
