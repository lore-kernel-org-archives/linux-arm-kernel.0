From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 30 Nov 2011 12:41:05 -0800
Subject: [RFC V1 1/8] clk: support static parent
In-Reply-To: <20111124003044.GA15876@b20223-02.ap.freescale.net>
References: <1322046755-13511-1-git-send-email-richard.zhao@linaro.org>
 <1322046755-13511-2-git-send-email-richard.zhao@linaro.org>
 <CAPtuhThVr8si2wRpx0i32=PQCC=4h1GZr6HkRsCLHbfXBef4XA@mail.gmail.com>
 <20111124003044.GA15876@b20223-02.ap.freescale.net>
Message-ID: <CAPtuhTg4a5gK96xd_jrFfYqqcdCLEFfT18_zTnufoSa4DCN2Ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 4:30 PM, Richard Zhao <richard.zhao@linaro.org> wrote:
> On Wed, Nov 23, 2011 at 02:11:40PM -0800, Mike Turquette wrote:
>> On Wed, Nov 23, 2011 at 3:12 AM, Richard Zhao <richard.zhao@linaro.org> wrote:
> This patch didn't remove .get_parent call. We trust .get_parent most.
> If .get_parent must not be NULL, clocks without mux have to duplicate
> the redundant get_parent function.

I've taken this in for V4 to accommodate DT clk binding support.  I've
put a comment in clk_init concerning use of .get_parent versus
statically initializing .parent.

Thanks,
Mike

>
> Thanks
> Richard
>>
>> Check out the way that the simple fixed-rate clk and simple gateable
>> clk does this in drivers/clk/clk-basic.c
>>
>> Regards,
>> Mike
>>
>> >
>> > ? ? ? ?if (clk->ops->recalc_rate)
>> > ? ? ? ? ? ? ? ?clk->rate = clk->ops->recalc_rate(clk);
>> > --
>> > 1.7.5.4
>> >
>> >
>> >
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
>
