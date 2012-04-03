From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 3 Apr 2012 15:12:30 +0530
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <20120403092524.GD17741@mudshark.cambridge.arm.com>
References: <CAAO=S0+L2Q1YZC-pfm2Lz8jPooTeHYOMaZbtRgHYFoL_m7rvhA@mail.gmail.com>
 <4F0B182D.7060507@us.ibm.com>
 <20120109224945.GA23090@mudshark.cambridge.arm.com>
 <CACVXFVMnAt_YpYNC5B6W4Vh4HvtVS3D6jRORUw0AW5a4ub5aOw@mail.gmail.com>
 <CAMsRxfJe_MEA=anzRu6jehGcZyg49uAx44_nDQ3_FRY=WrFLoA@mail.gmail.com>
 <CACVXFVNXJ2vZM-dAxQPQ5LSOuvv5yvOrnytOB9PxURtkaSCP8w@mail.gmail.com>
 <CACVXFVMH9WZDqs-mVjxL=1FY12uHyQAJMTCQuU5ru1wQT+YnZg@mail.gmail.com>
 <CAMQu2gzW706YbOzHa4Am0=X17T0G3zBhOmWUd8eC6GY9F6OBog@mail.gmail.com>
 <CACVXFVPb-McJj1oi284RW37Pe08cAXSw-jteFwfNVPpCJx5EaQ@mail.gmail.com>
 <CAMQu2gwvgPfZv_LnB6GnYs=Wt+wj9GFPEDYiDK6C8TiTag3gTg@mail.gmail.com>
 <20120403092524.GD17741@mudshark.cambridge.arm.com>
Message-ID: <CAMQu2gxE2STYxUGinzstX6W8jyofH829A__NQBjwLqZd9cqy=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 3, 2012 at 2:55 PM, Will Deacon <will.deacon@arm.com> wrote:
> Santosh,
>
> On Wed, Jan 18, 2012 at 12:33:23PM +0000, Shilimkar, Santosh wrote:
>> On Wed, Jan 18, 2012 at 1:24 PM, Ming Lei <ming.lei@canonical.com> wrote:
>> >>> diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c
>> >>> b/arch/arm/mach-omap2/clockdomains44xx_data.c
>> >>> index 9299ac2..41d2260 100644
>> >>> --- a/arch/arm/mach-omap2/clockdomains44xx_data.c
>> >>> +++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
>> >>> @@ -390,7 +390,7 @@ static struct clockdomain emu_sys_44xx_clkdm = {
>> >>> ? ? ? ?.prcm_partition ? = OMAP4430_PRM_PARTITION,
>> >>> ? ? ? ?.cm_inst ? ? ? ? ?= OMAP4430_PRM_EMU_CM_INST,
>> >>> ? ? ? ?.clkdm_offs ? ? ? = OMAP4430_PRM_EMU_CM_EMU_CDOFFS,
>> >>> - ? ? ? .flags ? ? ? ? ? ?= CLKDM_CAN_HWSUP,
>> >>> + ? ? ? .flags ? ? ? ? ? ?= CLKDM_CAN_SWSUP,
>> >>> ?};
>> >> NAK.
>> >>
>> >> You don't need this patch. What you saw on CAMERA was indeed
>> >> a known bug but emulation domain has no such issues.
>> >>
>> >> So the accesses to emulation register should continue to work
>> >> with the clock-domain being kept under hardware supervision.
>> >
>> > But why can this patch make omap4 pmu work? ?Without the patch,
>> > there are no CTI interrupts generated for pmu irq.
>> >
>> Interesting. For me debugger works which also relies on Emulation domain.
>>
>> Need to see why CTI is behaving like this.
>
> Did you ever get to the bottom of this? This change really is required in
> order to generate PMU interrupts with the CTI and I don't know of any
> alternative to the above.
>
> Any suggestions?
>
Sorry I lost track of this one. There is one relevant patch in Kevin's queue
for 3.4/fixes. [1] which I generated for perf time stamp issue.

Can you try that patch and see if it helps the CTI issue as well ? There
is an outside chance that it might help. If it doesn't, we should commit
Ming Lei  patch.

Regards
Santosh

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/089679.html
