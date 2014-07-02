From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 02 Jul 2014 14:41:54 +0200
Subject: ABBA deadlock in Common Clock Framework
In-Reply-To: <20140702114924.GC3679@tbergstrom-lnx.Nvidia.com>
References: <53B3E5F8.80501@samsung.com>
 <20140702114924.GC3679@tbergstrom-lnx.Nvidia.com>
Message-ID: <53B3FE12.3000608@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/14 13:49, Peter De Schrijver wrote:
> Or if you use notifiers which use i2c... See also
> http://comments.gmane.org/gmane.linux.kernel/1553699. One workaround is to
> always leave the clock of the i2c controller in a prepared state.

Keeping the clock always prepared might not be that bad, given
prepare/unprepare ops are empty on Exynos and I'd say chances
this ever changes are very low. Now we have just an overhead
of calling to the clock core before and after each single I2C
transfer.

--
Regards,
Sylwester
