From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 1 Mar 2016 12:51:22 +0000
Subject: for-next/pgtable branch: OOM error with 16K page size
In-Reply-To: <56D58872.2010506@arm.com>
References: <BY1PR0701MB159476A9E0E9B5DD9F17EC4BE1BA0@BY1PR0701MB1594.namprd07.prod.outlook.com>
 <BY1PR0701MB159496D44DB36F8C3699D3A5E1BB0@BY1PR0701MB1594.namprd07.prod.outlook.com>
 <56D57B9D.7020604@arm.com>
 <BY1PR0701MB1594A21349ED87C30F900102E1BB0@BY1PR0701MB1594.namprd07.prod.outlook.com>
 <56D58872.2010506@arm.com>
Message-ID: <56D5904A.3050300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/16 12:17, Suzuki K. Poulose wrote:
>
>> http://pastebin.com/Eszwp1cS
>
>> HugePages_Total:    2019
>> HugePages_Free:     2019
>> HugePages_Rsvd:        0
>> HugePages_Surp:        0
>> Hugepagesize:      32768 kB
>
> That clearly tells you whats wrong. You have 2019x32M in hugepages.
> Could you try releasing them and see if it solves the memory issue ?
>
> $ echo 0 > /sys/kernel/mm/hugepages/hugepages-32768kB/nr_hugepages
>
>
> btw, whats your root file system(to be more precise, the init) ?

Also, could you get the number of HugePages_Total with 4K and 64K ?

May be your init (or whatever allocates the hugepages) requires some
hints about 16K and do something similar to what it does for 64K.

Thanks
Suzuki
