From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 25 Jan 2013 13:07:06 +0100
Subject: [PATCH 1/2] ARM: dts: omap3-overo: Add support for pwm-leds
In-Reply-To: <51024254.40208@ti.com>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch>
 <1358963812-19947-2-git-send-email-florian.vaussard@epfl.ch>
 <5101510C.9050407@ti.com> <51015663.8080109@epfl.ch>
 <5101570A.1030303@ti.com> <5101663C.7020301@epfl.ch> <51016A84.20703@ti.com>
 <5101A43D.7080108@epfl.ch> <51024254.40208@ti.com>
Message-ID: <5102756A.9040901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2013 09:29 AM, Peter Ujfalusi wrote:
> On 01/24/2013 10:14 PM, Florian Vaussard wrote:
>> You are right. But then the pwm core must provide a way to know if the pwm
>> access function are callable
>> from atomic context or not (the gpio framework provides gpio_cansleep()).
>> This implies a good amount of changes to the pwm framework, and currently we
>> are the only driver using non-atomic access.
> 
> We have two drivers at the moment: pwm-twl and pwm-twl-led. However new out of
> SoC PWM drivers might come (for example for palmas). So it worth take a look
> at some generic implementation.

OK. So I have the series. I need to add few more things but pwm-leds on
BeagleBoard works fine when I put the default_trigger for the pmustat LED to
be mmc0. It is blinking happily ;)
I'll CC you with the patches when I send them.

-- 
P?ter
