From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Oct 2014 14:02:31 +0000
Subject: [PATCH v2 4/5] ARM: allow errata and XIP options to be enabled
 without ARCH_MULTIPLATFORM_STRICT
In-Reply-To: <1414503095-25986-5-git-send-email-kaixu.xia@linaro.org>
References: <1414503095-25986-1-git-send-email-kaixu.xia@linaro.org>
 <1414503095-25986-5-git-send-email-kaixu.xia@linaro.org>
Message-ID: <20141028140231.GE27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 09:31:34PM +0800, Xia Kaixu wrote:
> With the ARCH_MULTIPLATFORM_STRICT option, it becomes much easier to
> enable the ERRATA options when we know at configuration time that we
> don't care about the generic case. The previous configuration makes
> XIP_KERNEL option fundamentally non-MULTIPLATFORM, but it's still
> valid to select it when building for !ARCH_MULTIPLATFORM_STRICT and
> selecting only the one machine that you want to run on.

XIP_KERNEL isn't supported on anything past ARMv5 though.

I don't like the case for errata though - we want these errata to be
handled by the board firmware, not by the kernel, and we don't want
to make it any easier for people to ignore that fact.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
