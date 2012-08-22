From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 22 Aug 2012 10:42:40 -0400 (EDT)
Subject: [PATCH 4/4] ARM: kprobes: make more tests conditional
In-Reply-To: <1345645780-2749-5-git-send-email-arnd@arndb.de>
References: <1345645780-2749-1-git-send-email-arnd@arndb.de>
 <1345645780-2749-5-git-send-email-arnd@arndb.de>
Message-ID: <alpine.LFD.2.02.1208221040250.1754@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Aug 2012, Arnd Bergmann wrote:

> The mls instruction is not available in ARMv6K or below, so we
> should make the test conditional on at least ARMv7. ldrex/strex
> are available in ARMv6K or ARMv7, which we can test by checking
> the CONFIG_CPU_32v6K symbol. Just testing for ARMv6 is not enough.

The ldrex/strex instructions are available on ARMv6.  It's only the d 
variants (strexd/ldrexd) which are only available from ARMv6k.


Nicolas
