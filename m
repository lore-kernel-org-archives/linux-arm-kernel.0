From: schwab@suse.de (Andreas Schwab)
Date: Tue, 06 Oct 2015 13:52:24 +0200
Subject: [PATCHv2] ARM64:Fix MINSIGSTKSZ and SIGSTKSZ
In-Reply-To: <20151006113328.GP6281@e103592.cambridge.arm.com> (Dave Martin's
 message of "Tue, 6 Oct 2015 12:33:28 +0100")
References: <1444109743-8561-1-git-send-email-manjeet.p@samsung.com>
 <5022096.8QRzW0l3EJ@wuerfel>
 <20151006103128.GN6281@e103592.cambridge.arm.com>
 <5340366.WTVksOGb0G@wuerfel> <mvmh9m48dpa.fsf@hawking.suse.de>
 <20151006113328.GP6281@e103592.cambridge.arm.com>
Message-ID: <mvma8rw8b9j.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave Martin <Dave.Martin@arm.com> writes:

> On Tue, Oct 06, 2015 at 12:59:45PM +0200, Andreas Schwab wrote:
>> Arnd Bergmann <arnd@arndb.de> writes:
>> 
>> > I think it makes sense to stick with the traditional definition
>> > of MINSIGSTKSZ == "the minimum amount that you will always need,
>> > add whatever you require yourself" and SIGSTKSZ == "Should be
>> > enough for a couple of function calls".
>> 
>> The python3 testsuite wants to put two signal frames in a SIGSTKSZ
>> stack.
>
> Whether it's valid to expect SIGSTKSZ to be big enough for that is
> debatable.

This is tracked in <https://bugs.python.org/issue22503>.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
