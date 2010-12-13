From: ccross@android.com (Colin Cross)
Date: Mon, 13 Dec 2010 14:55:47 -0800
Subject: [PATCH] ARM: tegra: timer: Separate clocksource and sched_clock
In-Reply-To: <20101213135110.GL8665@n2100.arm.linux.org.uk>
References: <1290039615-23407-1-git-send-email-ccross@android.com>
	<20101213135110.GL8665@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinsELGgMFoVmTZuLPgaMCF5h0fos6u44z9VapHs@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 13, 2010 at 5:51 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Nov 17, 2010 at 04:20:15PM -0800, Colin Cross wrote:
>> tegra_clocksource_read should not use cnt32_to_63, wrapping is
>> already handled in the clocksource code. ?Move the cnt32_to_63
>> into the sched_clock function, and replace the use of clocksource
>> mult and shift with a multiplication by 1000 to convert us to ns.
>
> Colin,
>
> Mind if I pick this up into my tree - I'm doing other work with
> clocksources and sched_clock() at the moment which will clash with
> this patch.

Sure, I'll need to coordinate the Tegra tree with your tree already
because of the GIC and SMP changes.
