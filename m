From: florian@openwrt.org (Florian Fainelli)
Date: Fri, 12 Jul 2013 13:34:38 +0100
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <20130712121354.GG24008@pd.tnic>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <1367829775-4434-2-git-send-email-kyungsik.lee@lge.com>
 <20130712075602.GA4002@gmail.com>
 <20130712080145.GC24008@pd.tnic> <20130712101319.GA13421@gmail.com>
 <20130712102326.GE24008@pd.tnic>
 <20130712041810.53c86e5f.akpm@linux-foundation.org>
 <20130712121354.GG24008@pd.tnic>
Message-ID: <CAGVrzcZq-NQU=1UY7FpXPXZPFjJV7CQMsNQJbdY=bLTFVqGQHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

2013/7/12 Borislav Petkov <bp@alien8.de>:
> On Fri, Jul 12, 2013 at 04:18:10AM -0700, Andrew Morton wrote:
>> Well y'know, if whining fixed bugs then there would be no problem here
>> at all.
>
> I know. I decided to whine this time and not try to fix it because
> attempting to fix every fallout I'm seeing in the tree with randconfigs
> is a full-time job and the *actual* job doesn't see any progress.
>
> And in all fairness, if someone were reporting an issue against my code,
> I'll try to do my very best to fix it as quickly aas possible, instead
> of ignoring it.
>
> So actually, the right thing to do in such cases is back out half-cooked
> stuff from the tree until it gets fixed. That'll give the authors the
> right incentive. But this is just me.
>
>> This problem came up briefly and I thought it had been adequately
>> addressed. Now a month or two later we find out who are the people who
>> can't be bothered testing -next, but think it terribly important that
>> others do so.
>
> Yeah, if everyone would put their money where their mouth is...

Shall we provide a shell script wrapper for all of these compressor
commands which would test for the utility presence and issue a BIG FAT
WARNING if not, but still create the file not to make the kernel build
fail? I guess we could probably do this in the Makefile directly as
well.
--
Florian
