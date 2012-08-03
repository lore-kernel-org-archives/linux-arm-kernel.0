From: vikram.pandita@ti.com (Pandita, Vikram)
Date: Fri, 3 Aug 2012 15:25:17 -0700
Subject: [PATCH v3] printk: add option to print cpu id
In-Reply-To: <20120803221327.GA5102@kroah.com>
References: <1344013004-32211-1-git-send-email-vikram.pandita@ti.com>
 <m2628z6euk.fsf@firstfloor.org>
 <CAFm5wm3ScpUU5wa=ei3TY0zjU4kVbOgJMmE5_QDpwy7B-TJa+A@mail.gmail.com>
 <20120803200822.GC731@harshnoise.musicnaut.iki.fi>
 <CAFm5wm2sf9LnZNj9_BDYTF9G7XH32fOL3x5n=kZ-1ih0Cek2DQ@mail.gmail.com>
 <20120803215954.GA4489@kroah.com>
 <CAFm5wm1_-JP0xjDdBvAcqqpZPQvxJPsmNtUOFQyaNw=6H_JJcg@mail.gmail.com>
 <20120803221327.GA5102@kroah.com>
Message-ID: <CAFm5wm3ayofPD7oF1=z_jwE_wuqBxBHicAs=KOhjcUr7Jo0wDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 3, 2012 at 3:13 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Fri, Aug 03, 2012 at 03:07:39PM -0700, Pandita, Vikram wrote:
>> On Fri, Aug 3, 2012 at 2:59 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> > On Fri, Aug 03, 2012 at 02:24:20PM -0700, Pandita, Vikram wrote:
>> >> Aaro
>> >>
>> >> On Fri, Aug 3, 2012 at 1:08 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>> >> > Hi,
>> >> >
>> >> > On Fri, Aug 03, 2012 at 11:25:37AM -0700, Pandita, Vikram wrote:
>> >> >> > And really: Wasting 1/3 of the 80 character line is too much.
>> >> >>
>> >> >> You _WASTE_ 4 chars only if you are interested in this info by
>> >> >> enabling: CONFIG_PRINTK_CPUID
>> >> >
>> >> > I guess you waste 4 + 3 chars? You could optimize the length by checking
>> >> > CONFIG_NR_CPUS?
>> >>
>> >> Good point.
>> >> Looks there is a variable 'nr_cpu_ids' that could be used as well.
>> >>
>> >> If there is general consensus that the patch can help the arm
>> >> community, and others in general,
>> >> this optimization should be easy to implement - saving few chars space
>> >> in each line of console output.
>> >>
>> >> For now i will stick to this v3 version of path, unless you think otherwise.
>> >
>> > I don't think is is something that anyone needs, and if you do, as
>> > pointed out, you can use the trace function to make it happen.
>> >
>>
>> This was something that got used internally and helped at times.
>
> Could you have used the trace point instead?

As i understood the trace_prink(), one would need to modify existing
printk -> trace_printk. Is my understanding correct?

Most of the times the problem exhibits as a random hang, without having a clue
which code to modify. That time one generic defconfig global switch is
your first tool.

Other issue i found, using this patch, that on multi-core ARM systems,
almost 99% of times, IRQ's are handled by CPU0,
even if CPU0 was really busy and other CPU's were free. I am yet to
understand a good reason why.

this patch also helped in other areas as mentioned in the thread
http://marc.info/?l=linux-omap&m=134401269106619&w=2

Not sure how easy its to use trace_printk for such issues, i found
having one defconfig option was much easier
to get going. Correct me if i have not understood trace_printk well enough.


>
> greg k-h
