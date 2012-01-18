From: ming.lei@canonical.com (Ming Lei)
Date: Wed, 18 Jan 2012 12:18:46 +0800
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <CAMsRxfJe_MEA=anzRu6jehGcZyg49uAx44_nDQ3_FRY=WrFLoA@mail.gmail.com>
References: <CAAO=S0+L2Q1YZC-pfm2Lz8jPooTeHYOMaZbtRgHYFoL_m7rvhA@mail.gmail.com>
 <4F0B182D.7060507@us.ibm.com>
 <20120109224945.GA23090@mudshark.cambridge.arm.com>
 <CACVXFVMnAt_YpYNC5B6W4Vh4HvtVS3D6jRORUw0AW5a4ub5aOw@mail.gmail.com>
 <CAMsRxfJe_MEA=anzRu6jehGcZyg49uAx44_nDQ3_FRY=WrFLoA@mail.gmail.com>
Message-ID: <CACVXFVNXJ2vZM-dAxQPQ5LSOuvv5yvOrnytOB9PxURtkaSCP8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi stephane & Will,

On Tue, Jan 10, 2012 at 8:46 AM, stephane eranian
<eranian@googlemail.com> wrote:
> See the dmesg from my 3.2 kernel:
>
>
> [ ? ?0.000000] Booting Linux on physical CPU 0[ ? ?0.000000]

Looks no obvious failure can be found from your 'dmesg'.

I have run upstream 3.2 kernel plus 6 omap4 pmu patches below and
found perf can work well on my panda board.

	0001-arm-introduce-cross-trigger-interface-helpers.patch
	0002-arm-pmu-allow-platform-specific-irq-enable-disable-h.patch
	0003-arm-omap4-hwmod-introduce-emu-hwmod.patch or Benoit's debugss patch[2]
	0004-arm-omap4-create-pmu-device-via-hwmod.patch[3]
	0005-arm-omap4-support-pmu.patch[4]
	0006-arm-omap4-pmu-support-runtime-pm.patch[5]

Could you verify the above patches on 3.2 to see if perf can work well?
If it doesn't, I may share my u-boot and mlo for your test if you'd like to do.

BTW: #1 and #2 have been in Will's -next tree.

thanks,
--
Ming Lei

[1], uname -a & cat /proc/interrupts
[root at root]#uname -a
Linux beagleboard 3.2.0+ #480 SMP PREEMPT Wed Jan 18 11:38:33 CST 2012
armv7l GNU/Linux
[root at root]#cat /proc/interrupts
           CPU0       CPU1
 29:      29014      17353       GIC  twd
 33:      56231          0       GIC  arm-pmu
 34:          0      25778       GIC  arm-pmu

[2], http://marc.info/?l=linux-omap&m=132162118104901&w=2
[3],http://marc.info/?t=132227621500002&r=1&w=2
[4],http://marc.info/?t=132227621700002&r=1&w=2
[5],http://marc.info/?t=132227621700003&r=1&w=2
