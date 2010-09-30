From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 1 Oct 2010 08:52:11 +0900
Subject: [PATCH 7/7] ARM: S5PC210: I2C{3, 4, 5, 6, 7} device support
In-Reply-To: <00e201cb6094$c52391a0$4f6ab4e0$%szyprowski@samsung.com>
References: <20100930044859.GA16923@july>
	<000b01cb6067$99850240$cc8f06c0$%seo@samsung.com>
	<AANLkTinC9U3mehOVGWSM26TjMVyx9o6fBgLrXUKQmOcb@mail.gmail.com>
	<AANLkTik9Q7e=nzOmKsxEBeeJn-5JcQpKJfTSfGqLB21G@mail.gmail.com>
	<00e201cb6094$c52391a0$4f6ab4e0$%szyprowski@samsung.com>
Message-ID: <AANLkTikvsxXF+iXcfzLoMM+_2pr5zd1sYvhu1EVoBh+f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 30, 2010 at 8:43 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>> >> We are considering another way not to make additional new i2c dev files.
>> >> In my opinion, this patch looks not bad but we'd better make an effort to
>> >> avoid having the more similar file.
>> >
>> > Actually I also it's not good approach, but as there's no comment or
>> > discuss about this I send the patches.
>> > http://lists.infradead.org/pipermail/linux-arm-kernel/2010-August/022615.html
>> >
>> > If you have good method or approaches, I'm welcome.
>>
>> First, these are device definitions and gpio set callbacks and
>> shouldn't take much
>> of space. So, perhaps these all could be built upon single I2C support
>> selection.
>>
>> Second, if we must build them conditionally, how about having all in
>> one file with
>> each device's definition and callback surrounded by corresponding ifdef ?
>> That would alteast save us file-count.
>
> I don't think this is a good idea. IMHO we should now follow the current style
> of defining platform devices and the convert all at once. Mixing style always
> causes a lot of confusion.
You mean to keep defining every controller in in a dedicated file ?
If yes, my second option is still better, IMO.
If no, please explain what do you mean by current style.

> We should however agree on the new way of creating devices asap, as everyone
> can notice that the current style is not the best for advanced socs like
> C210/V310. This would save the time later when we would need to merge patches
> for different styles of devices.
I would prefer my first option out of all discussed in this thread.
