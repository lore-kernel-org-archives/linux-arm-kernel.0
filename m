From: jgchunter@gmail.com (Jon Hunter)
Date: Thu, 13 Jun 2013 17:41:26 +0100
Subject: [RFC PATCH] ARM: SOCFPGA: Enable PMU through the CTI
In-Reply-To: <20130515091205.GB12907@mudshark.cambridge.arm.com>
References: <1368586682-19848-1-git-send-email-dinguyen@altera.com>
 <20130515091205.GB12907@mudshark.cambridge.arm.com>
Message-ID: <51B9F636.5010708@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 15/05/13 10:12, Will Deacon wrote:
> Hello,
> 
> [adding Jon Hunter]
> 
> On Wed, May 15, 2013 at 03:58:02AM +0100, dinguyen at altera.com wrote:
>> From: Dinh Nguyen <dinguyen@altera.com>
>>
>> SOCFPGA has a PMU(Performance Measurement Unit) that has its
>> IRQs routed through Coresight using the CTI(Cross-Trigger Interface).
>>
>> This patch enables the PMU and initializes the CTI for usage by
>> oprofile/perfmon.
>>
>> A lot of the code/idea was taken from this:
>> https://patchwork.kernel.org/patch/1432541/
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
>> CC: Ming Lei <ming.lei@canonical.com>
>> CC: Will Deacon <will.deacon@arm.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> CC: Arnd Bergmann <arnd@arndb.de>
>> CC: Olof Johansson <olof@lixom.net>
>> Cc: Pavel Machek <pavel@denx.de>
>> ---
>>  arch/arm/boot/dts/socfpga.dtsi      |   18 +++++
>>  arch/arm/include/asm/pmu.h          |    3 +
>>  arch/arm/kernel/perf_event.c        |   16 +++++
>>  arch/arm/mach-socfpga/Makefile      |    1 +
>>  arch/arm/mach-socfpga/socfpga.c     |   21 +++++-
>>  arch/arm/mach-socfpga/socfpga_cti.c |  125 +++++++++++++++++++++++++++++++++++
>>  arch/arm/mach-socfpga/socfpga_cti.h |   16 +++++
>>  7 files changed, 199 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm/mach-socfpga/socfpga_cti.c
>>  create mode 100644 arch/arm/mach-socfpga/socfpga_cti.h
> 
> Whilst it's great to see somebody else making use of CTI, I think this would
> benefit from Jon's separate CTI driver that he posted once:
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/137156.html
> 
> Jon -- would you be interested in reviving that work so the socfpga guys can
> make use of it?

Sorry the delay I have been moving house!

Anyway, although I would be interesting in reviving and completing the
work on cti, realistically, I am not sure when I would get to it now. I
do have the latest code on my github account [1]. However, probably
still needs more work before it is ready for the mainline in sorting out
the DT bindings, etc. I was also thinking about making the cti look like
a interrupt controller in DT as that is the way it is currently being
used. However, I am not implemented that but should not be much work.

Cheers
Jon

[1] https://github.com/jonhunter/linux/commits/dev-cti
