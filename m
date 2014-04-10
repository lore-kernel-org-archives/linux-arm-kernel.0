From: monstr@monstr.eu (Michal Simek)
Date: Thu, 10 Apr 2014 08:12:17 +0200
Subject: [RFC PATCH] edac: add support for ARM PL310 L2 cache parity
In-Reply-To: <20140409174701.GO6529@pd.tnic>
References: <1393770760-32550-1-git-send-email-punnaia@xilinx.com>
 <a1a9e47a-069c-4285-9899-d5a58cf532c2@CO9EHSMHS003.ehs.local>
 <20140409113246.GA8778@pd.tnic>
 <CAL_Jsq+gszc+R_BrLtHKEBGYd=3T+sE1d+-HoF9aYZt6C2k5-g@mail.gmail.com>
 <20140409151932.GK6529@pd.tnic>
 <CAHLkNHJTA5bGD1zAfzE2JrDFAWvmgYyYjir+4vR-d9Fe2-E48g@mail.gmail.com>
 <20140409174701.GO6529@pd.tnic>
Message-ID: <53463641.1030800@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2014 07:47 PM, Borislav Petkov wrote:
> On Wed, Apr 09, 2014 at 10:59:49PM +0530, Punnaiah Choudary wrote:
>> There is a driver file cache-l2x0.c under arch/arm/mm for pl310 cache
>> configuration and management. Russel king had suggested to use
>> single driver file for both pl310 edac implementation and cache-l2x0.c
>> Here is the thread
>> http://www.spinics.net/lists/arm-kernel/msg320407.html
>>
>> please provide your inputs
> 
> Well, it is very simple - you don't really need an EDAC compilation unit
> just so that you can report errors - you can very well do that in your
> cache-l2x0.c and boom, problem solved.
> 
> Simply move the irq handler and the parity error checker to that file.

I am just curious about this recommendation. Does it mean that we shouldn't
use edac interface just for reporting problems?

I didn't play with it but I guess that there is a record about edac driver
via sysfs, etc. You could read some useful information that you know
what it is protected and I hope that edac interface bring any value
to reporting errors comparing to just printk message from IRQ handler.

My question is if using printk in IRQ handler and report problem is equal to
reporting this via edac interface. Or it is just easy way to do but
using edac interface is right solution and how to do it properly
is different question.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140410/0ef1acc7/attachment-0001.sig>
