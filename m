From: colin.tuckley@arm.com (Colin Tuckley)
Date: Fri, 29 Jan 2010 16:12:08 -0000
Subject: Uncompressing broken with commit e7db7b4270
In-Reply-To: <1264698229.7064.93.camel@pc1117.cambridge.arm.com>
References: <1264698229.7064.93.camel@pc1117.cambridge.arm.com>
Message-ID: <000001caa0fd$cef2f740$9fca010a@Emea.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org 
> Behalf Of Catalin Marinas

> For whatever reason, with commit e7db7b4270 (arm: add support for
> LZO-compressed kernels) if the kernel Image goes beyond a certain size
> it fails to uncompress. Reverting this commit solves the problem.
> Removing some random kernel features also solves the uncompressing as
> the kernel image gets smaller.

My experiments appear to show that the problem appears as the kernel image
grows above 2MB

When size is 2084132 (1.9MB) it boots

If I add something to make it slightly bigger (like Control Group
Support)...

then size is 2103332 (2.005MB) and it fails to uncompress.

I'm building a RealView PBX kernel for A9 (v7).

Colin


-- 
Colin Tuckley - ARM Ltd.
110 Fulbourn Rd
Cambridge, CB1 9NJ
Tel: +44 1223 400536 
