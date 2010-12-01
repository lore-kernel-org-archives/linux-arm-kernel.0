From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 1 Dec 2010 17:23:18 +0000
Subject: [PATCH] ARM: perf: use raw_spinlock_t for pmu_lock
In-Reply-To: <004e01cb9177$2760c460$76224d20$@deacon@arm.com>
References: <1291137443-13821-1-git-send-email-will.deacon@arm.com>
	<20101201163547.GE2898@pulham.picochip.com>
	<004e01cb9177$2760c460$76224d20$@deacon@arm.com>
Message-ID: <20101201172318.GG2898@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 01, 2010 at 04:45:25PM -0000, Will Deacon wrote:
> Hmm, I just use an smtp server for sending messages so the message *should*
> be ok. It's the receiving side of things where I get into trouble. If I look
> at the .patch I gave to git send-email with hexdump it has:
> 
> 000007d0  69 74 65 28 76 61 6c 29  3b 0a 2d 09 73 70 69 6e  |ite(val);.-.spin|
> 000007e0  5f 75 6e 6c 6f 63 6b 5f  69 72 71 72 65 73 74 6f  |_unlock_irqresto|
> 000007f0  72 65 28 26 70 6d 75 5f  6c 6f 63 6b 2c 20 66 6c  |re(&pmu_lock, fl|
> 00000800  61 67 73 29 3b 0a 2b 09  72 61 77 5f 73 70 69 6e  |ags);.+.raw_spin|
> 00000810  5f 75 6e 6c 6f 63 6b 5f  69 72 71 72 65 73 74 6f  |_unlock_irqresto|
> 00000820  72 65 28 26 70 6d 75 5f  6c 6f 63 6b 2c 20 66 6c  |re(&pmu_lock, fl|
> 00000830  61 67 73 29 3b 0a 20 7d  0a 20 0a 20 73 74 61 74  |ags);. }. . stat|
> 
> So it looks like tabs (ascii code 0x09) are being converted to =09 somewhere
> on your end. Mutt should be fine, what are you connecting it to?
I'm getting the email from gmail but if I use "show original" in the gmail web 
interface then it has the "=09"'s scattered through it. Your hw_breakpoint 
patches seem fine though so I'm not sure what's different.

Jamie
