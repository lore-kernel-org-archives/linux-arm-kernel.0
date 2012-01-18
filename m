From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Jan 2012 13:06:04 +0100
Subject: [PATCH 1/2] mach-ux500: cache operations are atomic on PL310
In-Reply-To: <20120117133428.GB11581@mudshark.cambridge.arm.com>
References: <1326346663-6112-1-git-send-email-srinidhi.kasagar@stericsson.com>
 <20120113181422.GB24373@mudshark.cambridge.arm.com>
 <20120116110528.GA24824@bnru02>
 <20120116145008.GH9068@mudshark.cambridge.arm.com>
 <20120117062224.GA26832@bnru02>
 <20120117103023.GB9230@mudshark.cambridge.arm.com>
 <20120117112741.GA14426@bnru02>
 <20120117133428.GB11581@mudshark.cambridge.arm.com>
Message-ID: <CACRpkdYfceJQtvmr7wMj=X+0T5XfLyJP=m3juVFT=uR0+get7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2012 at 2:34 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Jan 17, 2012 at 11:27:43AM +0000, Srinidhi KASAGAR wrote:

>> From a8cf7e2f7b58c3ef860be58fa72cd0c51e2be487 Mon Sep 17 00:00:00 2001
>> From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
>> Date: Tue, 17 Jan 2012 11:29:39 +0530
>> Subject: [PATCH] mach-ux500: Do not override outer.inv_all
>>
>> + ? ? /*
>> + ? ? ?* We can't disable l2 as we are in non secure mode, currently
>> + ? ? ?* this seems being called only during kexec path. So let's
>
> s/being/to be/
>
>> + ? ? ?* override outer.disable with nasty assignment until we have
>> + ? ? ?* some SMI service available.
>> + ? ? ?*/
>> + ? ? outer_cache.disable = NULL;
>
> This looks alright to me.
>
> Reviewed-by: Will Deacon <will.deacon@arm.com>

Thanks guys, applied to ux500-core with the speling fix above,
I will send this for the -rc series.

Yours,
Linus Walleij
