From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 1 Mar 2016 11:32:51 +0000
Subject: for-next/pgtable branch: OOM error with 16K page size
In-Reply-To: <BY1PR0701MB159496D44DB36F8C3699D3A5E1BB0@BY1PR0701MB1594.namprd07.prod.outlook.com>
References: <BY1PR0701MB159476A9E0E9B5DD9F17EC4BE1BA0@BY1PR0701MB1594.namprd07.prod.outlook.com>
 <BY1PR0701MB159496D44DB36F8C3699D3A5E1BB0@BY1PR0701MB1594.namprd07.prod.outlook.com>
Message-ID: <20160301113250.GA30602@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 01, 2016 at 10:48:02AM +0000, Jaggi, Manish wrote:
> 
> >>From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> on behalf of Jaggi, Manish <Manish.Jaggi@caviumnetworks.com>
> >>Sent: Monday, February 29, 2016 5:56 PM
> >>To: linux-arm-kernel at lists.infradead.org
> >>Subject: for-next/pgtable branch: OOM error with 16K page size
> >>
> >>Hi All,
> >>
> >>I am trying to use the for-next/pgtable branch with the top commit,
> 
> The same issue is observed with for-next/core branch

I take it that you do not see this issue on v4.5-rc4?

> >>commit 068a17a5805dfbca4bbf03e664ca6b19709cc7a8
> >>Author: Mark Rutland <mark.rutland@arm.com>
> >>Date:   Mon Jan 25 11:45:12 2016 +0000
> >>
> >>   arm64: mm: create new fine-grained mappings at boot
> >>
> >>Setup: ARMv8, Cavium ThunderX, 48Cores 64G ram.
> >>linux config: defconfig + 16k page size.
> >>
> >>Observations:
> >>a) During linux boot I see some oom messages
> >>http://pastebin.com/8jSMFhqf
> >>

Could you try again with "efi=debug"? If possible, also
"memblock=debug", though the latter will hugely increase the dmesg
output.

> >>b) cat /proc/meminfo
> >>
> >>MemTotal:         66613760 kB
> >>MemFree:          307328 kB
> >>MemAvailable:      22416 kB
> >>
> >>Available memory is very less compared to total.
> >>
> >>c) With 64K pagesize
> >>MemTotal:       66831552 kB
> >>MemFree:         3541184 kB
> >>MemAvailable:    3298752 kB

The former does look very odd.

Could you dump the full contents of /proc/meminfo for both of these
cases?

Thanks,
Mark.
