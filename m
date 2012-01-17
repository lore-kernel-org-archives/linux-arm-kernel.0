From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Jan 2012 21:58:09 +0000
Subject: [PATCH v2 0/8] S3C24XX: remove global plat/s3c24??.h SoC-headers
In-Reply-To: <201201172210.51953.heiko@sntech.de>
References: <201201172210.51953.heiko@sntech.de>
Message-ID: <20120117215809.GZ1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2012 at 10:10:51PM +0100, Heiko St?bner wrote:
>  53 files changed, 485 insertions(+), 509 deletions(-)
>  delete mode 100644 arch/arm/mach-s3c2410/common.h
>  create mode 100644 arch/arm/mach-s3c2410/s3c2410.h

Given the amount of pain we've recently been through creating common.h
in this merge window, I'm going to say no to getting rid of it this
early.  Hell, this merge window hasn't even closed and the file which
was created during it is already being deleted?

No, this isn't right.  Especially as you're having to change all the
#include statements in each mach-* file from common.h to s3c2410.h.
