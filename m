From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 6 Jun 2013 08:47:33 +0900
Subject: [PATCH 01/06] ARM: shmobile: Introduce SHMOBILE_FIXUP() helper
In-Reply-To: <20130605192019.GG18614@n2100.arm.linux.org.uk>
References: <20130605073410.15758.37563.sendpatchset@w520>
 <20130605073418.15758.93704.sendpatchset@w520>
 <20130605192019.GG18614@n2100.arm.linux.org.uk>
Message-ID: <CANqRtoRXDpdzTxJAZRe1cAVg0sPj8UuVfkR_bFUY-sKe7gnHUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, Jun 6, 2013 at 4:20 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jun 05, 2013 at 04:34:18PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Introduce SHMOBILE_FIXUP() as a helper function to
>> allow boards to specify their memory base and size.
>
> No.  I really don't like this idea (we've had people doing this in the
> past and I went around removing all that crap, and adding command line
> options into the defconfig files for those boards.)
>
> I also fail to understand why in 2013, some 11 years after ATAG stuff
> was created, people _still_ can't get pass correct information into
> the kernel.
>
> It's exactly this kind of issue which makes me believe that stuff like
> ACPI, UEFI and DT are doomed to fail on ARM because this kind of problem
> constantly crops up time and time again.  People have seem to have this
> total inability to get the pre-kernel environment right.

Thanks for your comments. As you probably saw in patch 00/06, the goal
with this series is to remove CONFIG_MEMORY_START/SIZE from
mach-shmobile.

I myself am quite happy to keep on using the kernel configuration to
describe the main memory window like today, this is exactly how we
used to do it on SH as well. What is a bit difficult is that we for
mach-shmobile are requested to consolidate the kernel configurations
and move to CONFIG_MULTIPLATFORM.

My main concern is that I'd like to keep per-board memory
configuration somewhere, just removing it seems like a regression in
usefulness to me. Do you have any recommendation for me how to
proceed?

Thanks,

/ magnus
