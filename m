From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 19 Jun 2015 10:40:15 +0200
Subject: [PATCH v7 04/14] crypto: add a new driver for Marvell's CESA
In-Reply-To: <20150619102407.01187ff0@free-electrons.com>
References: <1434635190-27733-1-git-send-email-boris.brezillon@free-electrons.com>	<1434635190-27733-5-git-send-email-boris.brezillon@free-electrons.com>	<20150619064256.GA10246@gondor.apana.org.au>
 <20150619102407.01187ff0@free-electrons.com>
Message-ID: <5583D56F.7020808@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas, Herbert,

On 19/06/2015 10:24, Thomas Petazzoni wrote:
> Hello Herbert,
> 
> On Fri, 19 Jun 2015 14:42:56 +0800, Herbert Xu wrote:
>> On Thu, Jun 18, 2015 at 03:46:20PM +0200, Boris Brezillon wrote:
>>>
>>> +	dram = mv_mbus_dram_info_nooverlap();
>>
>> This doesn't compile because it hasn't made it into mainline yet.
>> I'm afraid this patch-set will have to wait until that happens.
> 
> We have two options here:
> 
>  1/ We can ask the mach-mvebu maintainers to provide a branch with just
>     the commit implementing mv_mbus_dram_info_nooverlap(), and you
>     merge that branch into your tree as a dependency.

For this option you can use the branch mvebu/drivers located at
 git://git.infradead.org/linux-mvebu.git.

In this branch there is the commit "bus: mvebu-mbus: add mv_mbus_dram_info_nooverlap()"
but not only this one because it depends also on fixes which have been
merged in this same branch.

This branch is immutable and have already been merged in arm-soc.

Thanks,

Gregory

> 
>  2/ We temporarily revert back to using mv_mbus_dram_info(). For the
>     vast majority of platforms, this is OK. It's only if you have 4 GB
>     of RAM or more that it causes problem. And then we switch to
>     mv_mbus_dram_info_nooverlap() as part of the -rc cycle.
> 
> (2) is probably easier. Herbert, what do you think?
> 
> Thomas
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
