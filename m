From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 25 Jan 2013 09:29:08 +0100
Subject: [PATCH 1/2] ARM: dts: omap3-overo: Add support for pwm-leds
In-Reply-To: <5101A43D.7080108@epfl.ch>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch>
 <1358963812-19947-2-git-send-email-florian.vaussard@epfl.ch>
 <5101510C.9050407@ti.com> <51015663.8080109@epfl.ch>
 <5101570A.1030303@ti.com> <5101663C.7020301@epfl.ch> <51016A84.20703@ti.com>
 <5101A43D.7080108@epfl.ch>
Message-ID: <51024254.40208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/24/2013 10:14 PM, Florian Vaussard wrote:
> You are right. But then the pwm core must provide a way to know if the pwm
> access function are callable
> from atomic context or not (the gpio framework provides gpio_cansleep()).
> This implies a good amount of changes to the pwm framework, and currently we
> are the only driver using non-atomic access.

We have two drivers at the moment: pwm-twl and pwm-twl-led. However new out of
SoC PWM drivers might come (for example for palmas). So it worth take a look
at some generic implementation.

-- 
P?ter
