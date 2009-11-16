From: stevenrwalter@gmail.com (Steven Walter)
Date: Mon, 16 Nov 2009 12:23:36 -0500
Subject: cache aliasing in dup_mmap
In-Reply-To: <20091116163028.GA3568@n2100.arm.linux.org.uk>
References: <e06498070903062020s22222594h7be318fb9f3fdaee@mail.gmail.com>
	<20090308121029.GA21277@n2100.arm.linux.org.uk>
	<20090308143607.GA27349@n2100.arm.linux.org.uk>
	<e06498070909290925q55777041q6f3ecfaf9847babb@mail.gmail.com>
	<e06498070909290930w7745e1e3x2e224ad75ff62dbd@mail.gmail.com>
	<20090929191108.GA13568@n2100.arm.linux.org.uk>
	<20091005144623.GA20633@n2100.arm.linux.org.uk>
	<20091105144830.GC21681@n2100.arm.linux.org.uk>
	<e06498070911130649k2051e4cfh2066cf0b9fdabbaf@mail.gmail.com>
	<20091116163028.GA3568@n2100.arm.linux.org.uk>
Message-ID: <e06498070911160923i2273b6aai6f144b36289203d2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2009 at 11:30 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>> I apologize for the late reply. ?I have a build with your patches
>> running in a reboot loop (the easiest way for us to reproduce the
>> crash). ?I should have a good indication of whether the patches fix
>> the issue by Monday.
>
> Any results?

Yes, SIGSEGV after 88 boots, with a crash that we previously
identified as caused by this cache corruption issue.  Attached are the
patches I used, as manually backported to 2.6.18.5.  Stock 2.6.18.5
would reliably crash in under 1000 reboots, whereas  with my ad-hoc
fix (also attached) we were able to run 8000 reboots before we ended
the test.
-- 
-Steven Walter <stevenrwalter@gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: adhoc.patch
Type: text/x-patch
Size: 1087 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091116/97483bb4/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-pass-vma-to-copy_user_highpage.patch
Type: text/x-patch
Size: 3658 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091116/97483bb4/attachment-0001.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-call-flush_cache_page-before-copies.patch
Type: text/x-patch
Size: 2078 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091116/97483bb4/attachment-0002.bin>
