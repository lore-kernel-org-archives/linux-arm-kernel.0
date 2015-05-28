From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 28 May 2015 09:26:31 +0200
Subject: configuration for nc pins without pull
In-Reply-To: <20150322100059.GH5664@pengutronix.de>
References: <20150322100059.GH5664@pengutronix.de>
Message-ID: <20150528072631.GE24769@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 22, 2015 at 11:00:59AM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> for a machine I want to configure a pin that is actually not connected
> to minimize floating. (I think this is sensible, isn't it?)
> 
> For the pinctrl I can use a hog group of the pinctrl device. At least
> one of the pins doesn't have a pullup/pulldown configuration though, so
> I want to mux it to its gpio function and set the gpio to output and the
> desired value.
> 
> Is there something nicer than defining an always-on regulator with gpios
> = <&gpio4 3 0> to accomplish that without additional code?
For the archive: Yes, there is something nicer in the meantime:

Since commit f625d4601759 (gpio: add GPIO hogging mechanism) which is
included in v4.1-rc1 you can do something like

&gpio3 {
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_gpio3hog>;

        ext-armclk {
                gpio-hog;
                gpios = <15 0>;
                output-low;
        };
};

in the devicetree (here for an i.MX25).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
