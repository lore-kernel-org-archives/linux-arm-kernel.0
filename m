From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 04 Jan 2013 11:18:56 +0100
Subject: Early kernel hang with big DTB appended
In-Reply-To: <alpine.LFD.2.02.1301032144490.1263@xanadu.home>
References: <7811936.npteFbuYu2@amdc1227>
 <alpine.LFD.2.02.1301032144490.1263@xanadu.home>
Message-ID: <35730055.SShm3zF9mO@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

Thanks for your reply.

On Thursday 03 of January 2013 21:48:05 Nicolas Pitre wrote:
> On Thu, 3 Jan 2013, Tomasz Figa wrote:
> > Hi,
> > 
> > I'm observing strange behavior when booting 3.8-rc1 and -rc2 with
> > appended DTB. The kernel hangs very early when the DTB is bigger than
> > some threshold somewhere around 24 KiB.
> 
> What is the address where you load your zImage?

We are using uImages built with same parameters as those used in simple 
'make uImage', just with a DTB appended to zImage before running mkimage 
on it.

By default the load address is set to 0x40008000, where 0x40000000 is DRAM 
base.

> What if you load it, say, at an offset of 16MB from the start of RAM?
> Not that this is a fix, but at least that would help isolate the issue.

Yes, it indeed helps. I tried with shifting the load address by 16 MiB to 
0x41008000 (by adjusting mkimage parameters) and it now boots fine.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Linux Platform
