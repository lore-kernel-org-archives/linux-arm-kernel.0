From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 3 Apr 2012 18:11:24 +0530
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <20120403123444.GL17741@mudshark.cambridge.arm.com>
References: <CAMsRxfJe_MEA=anzRu6jehGcZyg49uAx44_nDQ3_FRY=WrFLoA@mail.gmail.com>
 <CACVXFVNXJ2vZM-dAxQPQ5LSOuvv5yvOrnytOB9PxURtkaSCP8w@mail.gmail.com>
 <CACVXFVMH9WZDqs-mVjxL=1FY12uHyQAJMTCQuU5ru1wQT+YnZg@mail.gmail.com>
 <CAMQu2gzW706YbOzHa4Am0=X17T0G3zBhOmWUd8eC6GY9F6OBog@mail.gmail.com>
 <CACVXFVPb-McJj1oi284RW37Pe08cAXSw-jteFwfNVPpCJx5EaQ@mail.gmail.com>
 <CAMQu2gwvgPfZv_LnB6GnYs=Wt+wj9GFPEDYiDK6C8TiTag3gTg@mail.gmail.com>
 <20120403092524.GD17741@mudshark.cambridge.arm.com>
 <CAMQu2gxE2STYxUGinzstX6W8jyofH829A__NQBjwLqZd9cqy=w@mail.gmail.com>
 <20120403094749.GH17741@mudshark.cambridge.arm.com>
 <CAMQu2gyFirtVTWpMu4G_qG5sq33J-_s_o2JhVAdrUf7P3qJ3AA@mail.gmail.com>
 <20120403123444.GL17741@mudshark.cambridge.arm.com>
Message-ID: <CAMQu2gwdMXAnvgWu-Mz_4qfRC9or7U8AngOS0N6vQhwU9vEppQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 3, 2012 at 6:04 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Apr 03, 2012 at 11:01:53AM +0100, Shilimkar, Santosh wrote:
>> On Tue, Apr 3, 2012 at 3:17 PM, Will Deacon <will.deacon@arm.com> wrote:
>> > It seems that they're both needed to get reliable PMU operation. Without the
>> > CLKDM_CAN_SWSUP fix, no interrupts are generated at all. Without the patch
>> > below ([1]), it seems that we don't generate enough. So it looks like we
>> > need them both.
>> >
>> I see. Can you please confirm if it is still the case with [1].
>
> Right, ignore my previous comment, I was using a vanilla 3.3 kernel without
> realising and therefore what I thought were PMU/CTI interrupts were actually
> just from a timer. Sorry for the confusion.
>
> So I've gone back to basics. Here is a branch containing what I believe
> should be all the patches required for the OMAP4 PMU:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git perf/omap4
>
> I've omitted the SWSUSP patch since you say it breaks pm, which is clearly not
> acceptable.
>
> The problem is, trying to boot this on my pandaboard results in a hang (see
> dmesg below). Even worse, the problem isn't easily bisectable since rebuilding
> a working image can give you something that no longer boots and I haven't found
> a reliable way to cause the lockup.
>
> I'll take JTAG for a whirl to see where we are. If anything looks wrong in
> my dmesg, please shout (there are plenty of things in there that look like
> they've gone awry).
>
I don't see anything abnormal in below boot log. Not sure why it
hands around there.

Regards
Santosh
