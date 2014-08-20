From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 Aug 2014 11:01:18 +0100
Subject: [PATCH] ARM: avoid corrupts register in mcaro kputc kphex etc.
In-Reply-To: <1408528202-152139-1-git-send-email-long.wanglong@huawei.com>
References: <1408528202-152139-1-git-send-email-long.wanglong@huawei.com>
Message-ID: <20140820100118.GH30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 20, 2014 at 05:50:02PM +0800, Wang Long wrote:
> when use macro 'kputc' kphex' to print the content of
> register r0-r3, they will corrupts these registers.
> 
> the same as the macro 'debug_reloc_start' and 'debug_reloc_end'.
> 
> so using 'push' when enter the macro and 'pop' when leave
> the macro to fix it.

NAK.  These are expected to corrupt r0-r3, and it is expected that
users of these macros save r0-r3 if they contain important values.
This is especially important as these get used in places where there
is no stack to save registers.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
