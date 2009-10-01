From: andreas.fenkart@streamunlimited.com (Andreas Fenkart)
Date: Thu,  1 Oct 2009 12:48:55 +0200
Subject: [PATCH 1/4] Made VMALLOC_END of type unsigned long. 
In-Reply-To: <20090810213905.GA4046@n2100.arm.linux.org.uk>
References: <20090810213905.GA4046@n2100.arm.linux.org.uk>
Message-ID: <1254394141-26673-1-git-send-email-andreas.fenkart@streamunlimited.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here it is, rebased against commit
7fa07729e439a6184bd824746d06a49cca553f15.

I added macros simplifying the printout message, as your suggested.
Patches are now split/merged differently so they describe one logical
step.

Unfortunately the macros you suggested trigger a checkpatch.pl
warning:

ERROR: Macros with complex values should be enclosed in parenthesis
#628: FILE: arm/mm/init.c:628:
+#define MLM(b, t) b, t, ((t) - (b)) >> 20

Resolving these results in a compiler warning:
arch/arm/mm/init.c:649: warning: left-hand operand of comma expression
has no effect

I resolved the compiler warning, since it likes an error too.

king regards

Andreas
