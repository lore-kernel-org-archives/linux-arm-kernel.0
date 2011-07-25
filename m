From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 25 Jul 2011 14:06:16 +0100
Subject: [PATCH 3/4] ARM: CPU hotplug: pass in proper affinity mask on
	IRQ migration
In-Reply-To: <4E2D63E3.8000308@ti.com>
References: <20110721151413.GD28942@n2100.arm.linux.org.uk>
	<E1Qjv7j-0003Ia-FD@rmk-PC.arm.linux.org.uk>
	<4E2D63E3.8000308@ti.com>
Message-ID: <20110725130616.GI9653@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 06:08:59PM +0530, Santosh Shilimkar wrote:
> On 7/21/2011 8:55 PM, Russell King - ARM Linux wrote:
>> +	if (cpumask_any_and(affinity, cpu_online_mask)>= nr_cpu_ids) {
>> +		affinity cpu_online_mask;
>
> I noticed, you missed '=' above and same is corrected in PATCH 4/4.
> Should be fixed in this patch itself to avoid git-bisect breakage.

Unfortuantely, too late...
