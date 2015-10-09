From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 09 Oct 2015 10:15:02 +0200
Subject: [PATCHv3 1/2] ARM: exynos_defconfig: Enable rtl8152 ethernet
 driver for Odroid-XU4
In-Reply-To: <CANAwSgS1AKwg8U0WBW8JmveHd0qdRL6RAOV4F4P22a9F28xopQ@mail.gmail.com>
References: <1444276117-3657-1-git-send-email-linux.amoon@gmail.com>
 <5551783.9EQ5GEjhxX@wuerfel>
 <CANAwSgS1AKwg8U0WBW8JmveHd0qdRL6RAOV4F4P22a9F28xopQ@mail.gmail.com>
Message-ID: <18718651.GRDoBKLmUe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 October 2015 09:14:33 Anand Moon wrote:
> As long as we use correct exynos5422-odroidxu4.dtb is used in the
> boot.scr/boot.ini ethernet come up,
> build and tested using CONFIG_USB_RTL8152=m using multi_v7_defconfig.
> 
> Not sure what is the policy for NFS booting.
> 
> Do you want CONFIG_USB_RTL8152 to be build as module in
> exynos/multi_v7_defconfig.

The NFS booting is exactly the question here: Would it be a significant
hassle for anyone to require using a ramdisk if they need NFS root?

If we all think it would be an acceptable price, we should probably
make all ethernet drivers loadable modules, as it is commonly
done on distros.

	Arnd
