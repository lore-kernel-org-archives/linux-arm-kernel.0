From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Nov 2014 13:07:23 +0100
Subject: [PATCH v2] arm: Support for the PXN CPU feature on ARMv7
In-Reply-To: <CAPP0e=PGo7UGso1eHhLW3ZCt7qb3dobsax7hpxECqAZFgiSBxQ@mail.gmail.com>
References: <1416981921-19643-1-git-send-email-js07.lee@gmail.com>
 <6108655.KIqtjFdn4U@wuerfel>
 <CAPP0e=PGo7UGso1eHhLW3ZCt7qb3dobsax7hpxECqAZFgiSBxQ@mail.gmail.com>
Message-ID: <6750653.pC5kYIxmFg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 November 2014 19:05:13 Jungseung Lee wrote:
> > The 'if (vmsa == 4)' check above looks like it came from an earlier version
> > and is always false, so just drop that.
> vmsa is static variable and it is intended to avoid read_cpuid_ext
> call at every cpu_has_classic_pxn() calling.
> Is it confused code or read_cpuid_ext() overhead is tiny to ignore?
> Kindly let me know your suggestion..

Sorry, my mistake. I missed the 'static' keyword. It might be nice to
add a comment in the function, in case someone else misses it too.

	Arnd
