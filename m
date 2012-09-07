From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Sep 2012 12:35:41 +0000
Subject: [PATCH 15/19] mfd: Don't convert just one IRQ using irqdomain if
 a range is provided
In-Reply-To: <1347016499-29354-16-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-16-git-send-email-lee.jones@linaro.org>
Message-ID: <201209071235.41785.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 September 2012, Lee Jones wrote:
> MFD core code attempts to convert specified hardware (local) IRQ
> numbers to virtual-IRQs, which something Linux can understand. This
> works great when only one IRQ is specified. However, converting
> entire ranges is currently unsupported. If this occurs we issue a
> kernel warning to inform the user of this, but we continue to
> convert the first specified IRQ anyway and replace the range. This
> is not the correct behaviour. This patch ensures that if a range
> is specified, it is left untouched.
> 
> CC: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I don't see the advantage of the change. The warning already tells
us that the input to mfd_add_device was incorrect, so nothing the
function does can reliably fix it. Leaving the resource empty
is just as wrong as listing only the first interrupt.

	Arnd
