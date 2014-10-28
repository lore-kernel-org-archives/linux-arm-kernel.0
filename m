From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Oct 2014 15:24:38 +0100
Subject: [PATCH v2 4/5] ARM: allow errata and XIP options to be enabled
 without ARCH_MULTIPLATFORM_STRICT
In-Reply-To: <20141028140231.GE27405@n2100.arm.linux.org.uk>
References: <1414503095-25986-1-git-send-email-kaixu.xia@linaro.org>
 <1414503095-25986-5-git-send-email-kaixu.xia@linaro.org>
 <20141028140231.GE27405@n2100.arm.linux.org.uk>
Message-ID: <6893071.4YhqEbdaBz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 October 2014 14:02:31 Russell King - ARM Linux wrote:
> On Tue, Oct 28, 2014 at 09:31:34PM +0800, Xia Kaixu wrote:
> > With the ARCH_MULTIPLATFORM_STRICT option, it becomes much easier to
> > enable the ERRATA options when we know at configuration time that we
> > don't care about the generic case. The previous configuration makes
> > XIP_KERNEL option fundamentally non-MULTIPLATFORM, but it's still
> > valid to select it when building for !ARCH_MULTIPLATFORM_STRICT and
> > selecting only the one machine that you want to run on.
> 
> XIP_KERNEL isn't supported on anything past ARMv5 though.

I would really like to get some of the platforms that currently use
XIP_KERNEL to use ARCH_MULTIPLATFORM in the long run. One of them
is EFM32, which is ARMv7-M.

> I don't like the case for errata though - we want these errata to be
> handled by the board firmware, not by the kernel, and we don't want
> to make it any easier for people to ignore that fact.

Ok, fair enough.

	Arnd
