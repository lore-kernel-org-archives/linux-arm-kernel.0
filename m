From: pieterg@gmx.com (pieterg)
Date: Mon, 27 Sep 2010 19:39:04 +0200
Subject: pxa3xx_nand issues
In-Reply-To: <201009271550.50399.pieterg@gmx.com>
References: <201009221912.24905.pieterg@gmx.com>
	<AANLkTi==hNcdTg9TNDxVmx4SuhnmDYXx_d_H1Q8Z6wOH@mail.gmail.com>
	<201009271550.50399.pieterg@gmx.com>
Message-ID: <201009271939.04710.pieterg@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 27 September 2010 15:50:50 pieterg wrote:
> On Monday 27 September 2010 14:22:37 Lei Wen wrote:
> > Does your jffs2 image make correct? Page size and block size set right?
>
> I think so.
> --eraseblock=0x20000 --pad --no-cleanmarkers

Well... that caused most of my problems.
--pad means pad to eraseblock size, not pagesize.
So the first writes in the new filesystem would cause pages in that last 
eraseblock to be overwritten.
With SLC I always got away with that, but with MLC, clearly not.

(now I'm still left with lots of singlebit errors, and occasional jffs2 CRC 
errors, pxa3xx_nand was obviously not meant to deal with such low quality 
MLC, no action is taken on bit errors, but at least everything can be 
explained now)

Thanks everybody for helping me find the cause of this problem.

Rgds, Pieter
