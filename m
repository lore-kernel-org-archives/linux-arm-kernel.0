From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Nov 2011 19:31:24 +0000
Subject: -next fails to boot as of today on S3C6410
In-Reply-To: <20111122192741.GG30583@opensource.wolfsonmicro.com>
References: <20111122192741.GG30583@opensource.wolfsonmicro.com>
Message-ID: <20111122193124.GB9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 07:27:41PM +0000, Mark Brown wrote:
> Testing with my s3c6410 based platform I'm seeing no output after
> "Uncompressing Linux... done, booting the kernel." when running -next.
> Yesterday's -next booted fine.
> 
> I've verified that this was introduced in the Russell's for-next, and
> bisection of that branch tells me that the offending commit is "ARM:
> vic: device tree binding" though an attempt to revert that in -next
> failed.  This is especially surprising as I have USE_OF turned off, I'm
> guessing that the issue is something to do with the conversion to use an
> irq_domain that happened in there.

Thanks for the report.  I'll hold off pushing this stuff into the
devel-stable branch while Jamie looks into this so that we can fix
it and avoid having a bisection failure in this set of commits.
