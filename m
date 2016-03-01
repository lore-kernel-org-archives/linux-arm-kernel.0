From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 1 Mar 2016 12:17:54 +0000
Subject: for-next/pgtable branch: OOM error with 16K page size
In-Reply-To: <BY1PR0701MB1594A21349ED87C30F900102E1BB0@BY1PR0701MB1594.namprd07.prod.outlook.com>
References: <BY1PR0701MB159476A9E0E9B5DD9F17EC4BE1BA0@BY1PR0701MB1594.namprd07.prod.outlook.com>
 <BY1PR0701MB159496D44DB36F8C3699D3A5E1BB0@BY1PR0701MB1594.namprd07.prod.outlook.com>
 <56D57B9D.7020604@arm.com>
 <BY1PR0701MB1594A21349ED87C30F900102E1BB0@BY1PR0701MB1594.namprd07.prod.outlook.com>
Message-ID: <56D58872.2010506@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/16 12:03, Jaggi, Manish wrote:
>>> From: Suzuki K. Poulose <Suzuki.Poulose@arm.com>
>>> Sent: Tuesday, March 1, 2016 4:53 PM
>>> To: Jaggi, Manish
>>> Cc: linux-arm-kernel at lists.infradead.org; mark.rutland at arm.com
>>> Subject: Re: for-next/pgtable branch: OOM error with 16K page size
>>>

>>> Could you please provide the complete o/p of the following
>>> with 16K ?
>>>
>>> 1) /proc/meminfo

> http://pastebin.com/Eszwp1cS

> HugePages_Total:    2019
> HugePages_Free:     2019
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> Hugepagesize:      32768 kB

That clearly tells you whats wrong. You have 2019x32M in hugepages.
Could you try releasing them and see if it solves the memory issue ?

$ echo 0 > /sys/kernel/mm/hugepages/hugepages-32768kB/nr_hugepages


btw, whats your root file system(to be more precise, the init) ?

Cheers
Suzuki
