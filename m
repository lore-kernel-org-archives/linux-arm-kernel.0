From: stevenrwalter@gmail.com (Steven Walter)
Date: Mon, 16 Nov 2009 16:50:38 -0500
Subject: cache aliasing in dup_mmap
In-Reply-To: <20091116172856.GE3568@n2100.arm.linux.org.uk>
References: <20090308121029.GA21277@n2100.arm.linux.org.uk>
	<e06498070909290925q55777041q6f3ecfaf9847babb@mail.gmail.com>
	<e06498070909290930w7745e1e3x2e224ad75ff62dbd@mail.gmail.com>
	<20090929191108.GA13568@n2100.arm.linux.org.uk>
	<20091005144623.GA20633@n2100.arm.linux.org.uk>
	<20091105144830.GC21681@n2100.arm.linux.org.uk>
	<e06498070911130649k2051e4cfh2066cf0b9fdabbaf@mail.gmail.com>
	<20091116163028.GA3568@n2100.arm.linux.org.uk>
	<e06498070911160923i2273b6aai6f144b36289203d2@mail.gmail.com>
	<20091116172856.GE3568@n2100.arm.linux.org.uk>
Message-ID: <e06498070911161350v485f0451p7828e6aa9120fe40@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2009 at 12:28 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>> Yes, SIGSEGV after 88 boots, with a crash that we previously
>> identified as caused by this cache corruption issue. ?Attached are the
>> patches I used, as manually backported to 2.6.18.5. ?Stock 2.6.18.5
>> would reliably crash in under 1000 reboots, whereas ?with my ad-hoc
>> fix (also attached) we were able to run 8000 reboots before we ended
>> the test.
>
> What is copypage-swl.S ?

copypage-swl.S contains optimized copy_user / clear_user routines for
the custom ASIC we use.  Preimage attached.
-- 
-Steven Walter <stevenrwalter@gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: copypage-swl.S
Type: application/octet-stream
Size: 2592 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091116/24fb096c/attachment.obj>
