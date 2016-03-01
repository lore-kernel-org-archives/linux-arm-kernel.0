From: Manish.Jaggi@caviumnetworks.com (Jaggi, Manish)
Date: Tue, 1 Mar 2016 10:48:02 +0000
Subject: for-next/pgtable branch: OOM error with 16K page size
In-Reply-To: <BY1PR0701MB159476A9E0E9B5DD9F17EC4BE1BA0@BY1PR0701MB1594.namprd07.prod.outlook.com>
References: <BY1PR0701MB159476A9E0E9B5DD9F17EC4BE1BA0@BY1PR0701MB1594.namprd07.prod.outlook.com>
Message-ID: <BY1PR0701MB159496D44DB36F8C3699D3A5E1BB0@BY1PR0701MB1594.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>>From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> on behalf of Jaggi, Manish <Manish.Jaggi@caviumnetworks.com>
>>Sent: Monday, February 29, 2016 5:56 PM
>>To: linux-arm-kernel at lists.infradead.org
>>Subject: for-next/pgtable branch: OOM error with 16K page size
>>
>>Hi All,
>>
>>I am trying to use the for-next/pgtable branch with the top commit,

The same issue is observed with for-next/core branch

>>
>>
>>commit 068a17a5805dfbca4bbf03e664ca6b19709cc7a8
>>Author: Mark Rutland <mark.rutland@arm.com>
>>Date:   Mon Jan 25 11:45:12 2016 +0000
>>
>>   arm64: mm: create new fine-grained mappings at boot
>>
>>Setup: ARMv8, Cavium ThunderX, 48Cores 64G ram.
>>linux config: defconfig + 16k page size.
>>
>>Observations:
>>a) During linux boot I see some oom messages
>>http://pastebin.com/8jSMFhqf
>>
>>b) cat /proc/meminfo
>>
>>MemTotal:         66613760 kB
>>MemFree:          307328 kB
>>MemAvailable:      22416 kB
>>
>>Available memory is very less compared to total.
>>
>>c) With 64K pagesize
>>MemTotal:       66831552 kB
>>MemFree:         3541184 kB
>>MemAvailable:    3298752 kB
>>
>>So it seems there is some issue with 16k only.
>>Need some inputs how to fix this
>>
>> Regards,
>>Manish Jaggi
