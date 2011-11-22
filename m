From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 22 Nov 2011 19:27:41 +0000
Subject: -next fails to boot as of today on S3C6410
Message-ID: <20111122192741.GG30583@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Testing with my s3c6410 based platform I'm seeing no output after
"Uncompressing Linux... done, booting the kernel." when running -next.
Yesterday's -next booted fine.

I've verified that this was introduced in the Russell's for-next, and
bisection of that branch tells me that the offending commit is "ARM:
vic: device tree binding" though an attempt to revert that in -next
failed.  This is especially surprising as I have USE_OF turned off, I'm
guessing that the issue is something to do with the conversion to use an
irq_domain that happened in there.
