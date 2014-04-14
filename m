From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 14 Apr 2014 14:00:31 -0300
Subject: [PATCH v2 0/4] ARM: mvebu: fix bus width handling in mvebu-devbus
In-Reply-To: <1397489361-5833-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397489361-5833-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140414170031.GB527@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Apr 14, Thomas Petazzoni wrote:
> Jason, Greg, Andrew, Sebastian,
> 
> This set of patches fix a bug in the mvebu-devbus driver, which was
> leading to a misinterpretation of Device Tree provided value: a NOR
> bus width declared as 8 bits in the Device Tree was in fact configured
> as 16 bits at the hardware level.
> 
> This bug was not noticed until now, because it was compensated by a
> symetric mistake in the Device Tree files.
> 
> This set of commits therefore fix both the driver itself, and the
> incorrect Device Tree files. The patches for the Device Tree files
> have been separated, because some of them should apply all the way to
> v3.10, while some of them apply only up to v3.11.
> 
> Changes since v1:
> 
>  * Added patches to fix the Device Tree files to indicate the correct
>    bus width, as documented in the board schematics. Noticed by
>    Ezequiel Garcia.
> 
>  * Changed the bus_width conversion logic in the driver to only accept
>    valid values: 8 bits and 16 bits. All other values lead to an error
>    being returned. Suggested by Sebastian Hesselbarth.
> 
>  * Rebased on top of v3.15-rc1.
> 

Thanks a lot for taking care of this!

Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
