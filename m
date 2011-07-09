From: ccross@android.com (Colin Cross)
Date: Sat, 9 Jul 2011 14:32:37 -0700
Subject: [PATCH 02/17] ARM: Add cpu power management notifiers
In-Reply-To: <20110709101528.GI4812@n2100.arm.linux.org.uk>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-3-git-send-email-lorenzo.pieralisi@arm.com>
	<20110709101528.GI4812@n2100.arm.linux.org.uk>
Message-ID: <CAMbhsRQndQJA9H9Q7F-DgDFDzmt60xZSSkNSm-C2-Odv5x2W4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 9, 2011 at 3:15 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jul 07, 2011 at 04:50:15PM +0100, Lorenzo Pieralisi wrote:
>> During some CPU power modes entered during idle, hotplug and
>> suspend, peripherals located in the CPU power domain, such as
>> the GIC and VFP, may be powered down. ?Add a notifier chain
>> that allows drivers for those peripherals to be notified
>> before and after they may be reset.
>
> I defer comment on this until I see what the CPU_COMPLEX_* stuff is used
> for.
>

Per previous discussions on this patch, CPU_COMPLEX_* will be renamed
CPU_CLUSTER_*, and will refer to all the gunk around the CPU that may
be shared by another CPU.  In this series, it is only used to save and
restore the GIC distributor registers, but it could be used for L2 as
well, if any platforms can agree on what needs to happen to the L2,
and when.
