From: albin.tonnerre@gmail.com (Albin Tonnerre)
Date: Sat, 13 Nov 2010 11:47:41 +0100
Subject: [PATCH] ARM: add support for uncompressed uImage kernel
In-Reply-To: <20101109140455.GA6680@n2100.arm.linux.org.uk>
References: <1289310656-29502-1-git-send-email-alexander.stein@systec-electronic.com>
	<20101109140455.GA6680@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=6OE=50EExgkay2ycuSPFsOp4E-RmxkNktK_Xk@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 9, 2010 at 3:04 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Is it really faster to copy an uncompressed image than it is to
> decompress using LZMA with caches on?

In my experience, using LZMA is painfully slow on older ARM CPUs.

If you really need to boot quickly you might want to try LZO, which
should give you results close to the uncompressed performance. It
might still be slower though, especially if you're able to load your
kernel image to memory fairly quickly

Regards,
-- 
Albin Tonnerre
