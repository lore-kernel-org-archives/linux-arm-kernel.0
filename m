From: ccross@google.com (Colin Cross)
Date: Tue, 28 Jun 2011 15:58:57 -0700
Subject: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
In-Reply-To: <20110628225523.GA23312@n2100.arm.linux.org.uk>
References: <1308923618-5333-1-git-send-email-premi@ti.com>
	<CAMbhsRQUKBZbC3jJt8XpjTW2n7uA529D6G0g4eT5iLEHn2iNLg@mail.gmail.com>
	<20110628225523.GA23312@n2100.arm.linux.org.uk>
Message-ID: <CAMbhsRQjMmXrULVmFg9CoM0wzZ29wcHqEaT480NaDhB8hHEKZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 3:55 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jun 28, 2011 at 03:29:57PM -0700, Colin Cross wrote:
>> Can't this rewrite the loops_per_jiffy for the other CPU while it is
>> in a udelay? ?If it has already calculated the number of loops
>> necessary, and the CPU frequency increases, it could end up returning
>> too early from udelay.
>
> udelay uses the global loops_per_jiffy.
>

The problem is still the same - loops_per_jiffy applies to both CPUs,
and the frequency of the other CPU cannot be changed if it is in a
udelay.
