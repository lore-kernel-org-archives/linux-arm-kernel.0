From: ccross@android.com (Colin Cross)
Date: Tue, 25 Jan 2011 10:44:49 -0800
Subject: [PATCH 3/5] ARM: twd: Add context save restore support
In-Reply-To: <20110125112946.GA13300@n2100.arm.linux.org.uk>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
	<1295859080-15259-4-git-send-email-santosh.shilimkar@ti.com>
	<20110124110609.GJ16202@n2100.arm.linux.org.uk>
	<20110124111114.GA19409@n2100.arm.linux.org.uk>
	<AANLkTikLDamkp9TgnWRESyx4=698D4NXP=W_M9=abfax@mail.gmail.com>
	<20110125112946.GA13300@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimAkfwKB2yt0h-tvgQpMMBHhxvRXEUnOnZLZdUV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 25, 2011 at 3:29 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jan 24, 2011 at 11:39:13PM -0800, Colin Cross wrote:
>> This doesn't work for oneshot timers if the TWD_TIMER_CONTROL register
>> gets reset by cpu idle between twd_set_mode and twd_set_next_event.
>> Shadowing ctrl in a percpu variable and rewriting it during every call
>> to twd_set_next_event does work, but that's not much different, and a
>> little less efficient, than just saving and restoring the control and
>> load registers in idle. ?It does have the advantage that platforms
>> don't need any extra calls.
>
> BTW, do you think the patch is, nevertheless, an improvement and something
> we should do? ?If so, please can I have your ack for it?

This patch does work after adding the missing clockevent broadcasts to
the Tegra idle driver, and allows me to remove all references to twd
registers in the idle and suspend code, so:
Acked-by: Colin Cross <ccross@android.com>
