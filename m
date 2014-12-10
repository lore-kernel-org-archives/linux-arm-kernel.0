From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 10 Dec 2014 17:43:33 +0100
Subject: BCM2048 bluetooth connected over OMAP serial
Message-ID: <20141210164333.GA3154@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

So, there's bluetooth chip that's connected to the SoC by UART and some
GPIOs. What would be right representation in the device tree?
Something like this?

	bluetooth {
                  compatible = "broadcom,bcm2048";
                  uart = <&uart2>;
                  reset-gpios = <&gpio3 27 GPIO_ACTIVE_HIGH>; /* want 91 */
                  host-wakeup-gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>; /* want 101 */
	          bluetooth-wakeup-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>; /* want 37 */
                  chip-type = <3>;
                  bt-sysclk = <2>;
                  reset-gpio-shared = <0>;
        };

Is there some way to prevent OMAP tty driver from binding to the
device and exporting the device to userspace?

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
