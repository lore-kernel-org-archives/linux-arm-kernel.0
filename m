From: N.Voss@weinmann.de (Voss, Nikolaus)
Date: Tue, 24 Apr 2012 06:51:03 +0200
Subject: [PATCH] drivers/rtc/rtc-m41t93.c: don't let get_time() reset
 error state
In-Reply-To: <20120423135322.5b9b1635.akpm@linux-foundation.org>
References: <201204231230.q3NCUbbP015327@gatekeeper.vosshq.de>
 <20120423135322.5b9b1635.akpm@linux-foundation.org>
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D0905DB4A4A@wm021.weinmann.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew Morton wrote on 2012-04-23:
> On Mon, 23 Apr 2012 12:51:23 +0200
> Nikolaus Voss <n.voss@weinmann.de> wrote:
> 
>> If the rtc reports the time might be invalid due to oscillator
>> failure, this flags must not be reset by get_time() as the read
>> operation doesn't make the time valid.
>> 
>> Instead, the flag is reset in set_time() when a valid time is
>> to be written.
> 
> This is rather vague - what is/are "these flags"?

Sorry, that's true. I speak of the M41T93_FLAG_OF
(Oscillator Fail) flag.

[...]
> Secondly, you provided no description of the user-visible effects of
> the bug.  Hence I cannot work out which kernel version(s) this patch
> should be merged into.

What the user sees is that the first get_time() read reports
an error (invalid time) and the second reports no error, so the
first read magically heals the rtc time.

The patch applies to all kernel versions with support for m41t93 rtc.

I'll repost the patch with a proper description.

Niko
