From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 10 Jul 2013 19:23:58 +0200
Subject: NSA310 + DT
In-Reply-To: <51DD96B9.8030900@harsszegi.com>
References: <51DC564A.8050002@harsszegi.com> <20130709193605.GC26223@lunn.ch>
 <20130709202143.GD26223@lunn.ch>
 <2544f179ed4349545a25aa60d52a664a@harsszegi.com>
 <20130710134119.GA30885@lunn.ch> <51DD8E8B.2040505@harsszegi.com>
 <20130710165342.GA31692@lunn.ch> <51DD926C.1010205@harsszegi.com>
 <51DD964C.7020200@harsszegi.com> <51DD96B9.8030900@harsszegi.com>
Message-ID: <20130710172358.GB31692@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 10, 2013 at 07:15:37PM +0200, Tibor Harsszegi wrote:
> Ok, was too fast :(
> After a reboot the LEDs are gone, all green :(

Please do not top post. Answer comes after questions, not before...

root at qnap:/sys# find . -name *gpio*
./bus/platform/devices/gpio_keys.1
./bus/platform/devices/f1010140.gpio
./bus/platform/devices/f1010100.gpio
./bus/platform/drivers/leds-gpio
./bus/platform/drivers/mvebu-gpio
./bus/platform/drivers/mvebu-gpio/f1010140.gpio
./bus/platform/drivers/mvebu-gpio/f1010100.gpio
./bus/platform/drivers/poweroff-gpio
./bus/platform/drivers/gpio-keys
./bus/platform/drivers/gpio-keys/gpio_keys.1
./devices/gpio_keys.1
./devices/ocp.0/f1010140.gpio
./devices/ocp.0/f1010140.gpio/gpio
./devices/ocp.0/f1010140.gpio/gpio/gpiochip32
./devices/ocp.0/f1010140.gpio/gpio/gpiochip32/ngpio
./devices/ocp.0/f1010100.gpio
./devices/ocp.0/f1010100.gpio/gpio
./devices/ocp.0/f1010100.gpio/gpio/gpiochip0
./devices/ocp.0/f1010100.gpio/gpio/gpiochip0/ngpio
./class/gpio
./class/gpio/gpiochip32
./class/gpio/gpiochip0

You should have something similar.

I have no LEDs on this box, but you should should see entries in

/sys/class/leds

What you probably see in the kernel logs is lots of warnings from gpio
about deferred, but then they get repeated later and are successful.

	Andrew
