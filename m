From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 31 Mar 2015 08:09:46 -0700
Subject: [PATCH v3 2/2] watchdog: digicolor: driver for Conexant Digicolor
 CX92755 SoC
In-Reply-To: <c765076e13eb2407541c256d4c527bbacb53ddd8.1427782499.git.baruch@tkos.co.il>
References: <9995b9d0be8cda30103be7406a781cd79f347aeb.1427782499.git.baruch@tkos.co.il>
 <c765076e13eb2407541c256d4c527bbacb53ddd8.1427782499.git.baruch@tkos.co.il>
Message-ID: <551AB8BA.1040703@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/30/2015 11:14 PM, Baruch Siach wrote:
> This commit add a driver for the watchdog functionality of the Conexant CX92755
> SoC, from the Digicolor series of SoCs. Of 8 system timers provided by the
> CX92755, the first one, timer A, can reset the chip when its counter reaches
> zero. This driver uses this capability to provide userspace with a standard
> watchdog, using the watchdog timer driver core framework. This driver also
> implements a reboot handler for the reboot(2) system call.
>
> The watchdog driver shares the timer registers with the CX92755 timer driver
> (drivers/clocksource/timer-digicolor.c). The timer driver, however, uses only
> timers other than A, so both drivers should coexist.
>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
