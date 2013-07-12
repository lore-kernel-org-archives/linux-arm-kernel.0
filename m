From: bp@alien8.de (Borislav Petkov)
Date: Fri, 12 Jul 2013 14:46:57 +0200
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <CAGVrzcZq-NQU=1UY7FpXPXZPFjJV7CQMsNQJbdY=bLTFVqGQHA@mail.gmail.com>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <1367829775-4434-2-git-send-email-kyungsik.lee@lge.com>
 <20130712075602.GA4002@gmail.com> <20130712080145.GC24008@pd.tnic>
 <20130712101319.GA13421@gmail.com> <20130712102326.GE24008@pd.tnic>
 <20130712041810.53c86e5f.akpm@linux-foundation.org>
 <20130712121354.GG24008@pd.tnic>
 <CAGVrzcZq-NQU=1UY7FpXPXZPFjJV7CQMsNQJbdY=bLTFVqGQHA@mail.gmail.com>
Message-ID: <20130712124657.GH24008@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 12, 2013 at 01:34:38PM +0100, Florian Fainelli wrote:
> Shall we provide a shell script wrapper for all of these compressor
> commands which would test for the utility presence and issue a BIG FAT
> WARNING if not, but still create the file not to make the kernel build
> fail? I guess we could probably do this in the Makefile directly as
> well.

I don't know how that would work with the main kernel Makefile
but we do those kinds of tests in perf before we build it so
that we can save ourselves the time spent on a failed build:
2209001fd895e8932ae2c85bfca233758234499a.

This should probably work if you add a prerequisite target which runs
early in the build process and checks for all the userspace tools
required for the build.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
