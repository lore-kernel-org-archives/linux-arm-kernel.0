From: js@sig21.net (Johannes Stezenbach)
Date: Wed, 22 Aug 2012 12:34:43 +0200
Subject: [GIT PULL v2] Update LZO compression
In-Reply-To: <5033A78E.3080703@oberhumer.com>
References: <5033A78E.3080703@oberhumer.com>
Message-ID: <20120822103443.GA15245@sig21.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 05:21:50PM +0200, Markus F.X.J. Oberhumer wrote:
> as suggested on the mailing list I have converted the updated LZO
> code into git, so please pull my "lzo-update" branch from
...
> [ Changes in v2: Optimize code for CPUs with inefficient unaligned
>   access => significant speed increase on ARM ]

I can confirm that this new code runs at the same speed
as the current lzo code in the Linux kernel on
my ARM926EJ-S based platform.  I only tested decompression,
using the attached hacky userspace code.

   # time ./lzo-bench/old/unlzop <lzoimage >/dev/null
   real    0m 0.29s
   # time ./lzo-bench/new/unlzop <lzoimage >/dev/null
   real    0m 0.29s

   (where lzoimage is a Linux Image compressed with lzop)

So, from my side there are no more objections.
Thanks for doing this work, Markus.


Johannes
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lzo-bench.tar.gz
Type: application/octet-stream
Size: 35783 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120822/ee82ee5e/attachment-0001.obj>
