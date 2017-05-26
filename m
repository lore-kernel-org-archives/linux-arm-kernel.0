From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Fri, 26 May 2017 21:54:19 +0000
Subject: [PATCH 1/4] ARM: ep93xx: switch to SPARSEMEM
In-Reply-To: <0dc7d7be-31bd-fbcd-25c2-efa6b044c392@gmail.com>
References: <20170221181529.6780-1-hsweeten@visionengravers.com>
 <20170221181529.6780-2-hsweeten@visionengravers.com>
 <440efa53-dbbf-5600-3441-87c6891c5389@gmail.com>
 <c5d6d870-48f8-f6c4-1ec9-6b540d0dca98@gmail.com>
 <2e8ab3d4-21ab-44e6-1b77-4db381a55fcf@gmail.com>
 <0dc7d7be-31bd-fbcd-25c2-efa6b044c392@gmail.com>
Message-ID: <BLUPR0101MB1554E6802FA753B6B0A25E44D0FC0@BLUPR0101MB1554.prod.exchangelabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, May 26, 2017 2:50 PM, Florian Fainelli wrote:
> On 05/26/2017 02:28 PM, Alexander Sverdlin wrote:
>> I've applied the patch to 4.12-rc2 as well (to be more precise, 1b8f2ffc of Linus's tree),
>> and it boots fine on EDB9302 (32MiB one chip on SDCS3). I even ran "memtester" fine, one
>> iteration.
>
> I need to debug this further because it does not make sense to me why
> this patch on 4.12-rc1 works but on on 4.1-2-rc2 other than just having
> a bit more bloat one image vs. another.

The bloat might be the problem.

In my earlier testing with the TS-7300 I found that if my uncompressed image/rootfs was
larger than then SDRAM segment size the system would not boot. I think I sent an email
to you regarding this when I was first trying to get the TS-7300 to boot a newer kernel.

Hartley
