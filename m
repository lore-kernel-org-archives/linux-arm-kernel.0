From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 03 Nov 2011 17:27:29 +0100
Subject: [PATCH 1/3] ARM: AT91: Add platform data for the ADCs
In-Reply-To: <CAKnu2MqTVPxioKyr-F6JWcdF5SRZjzLSFPt5A-6CkZO7HyeHRw@mail.gmail.com>
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com>
	<1320315070-1700-1-git-send-email-maxime.ripard@free-electrons.com>
	<1320315070-1700-2-git-send-email-maxime.ripard@free-electrons.com>
	<CAKnu2MqTVPxioKyr-F6JWcdF5SRZjzLSFPt5A-6CkZO7HyeHRw@mail.gmail.com>
Message-ID: <4EB2C0F1.1030404@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 03/11/2011 12:27, Linus Walleij wrote:
> 2011/11/3 Maxime Ripard <maxime.ripard@free-electrons.com>:
> 
>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>>  arch/arm/mach-at91/include/mach/board.h |   22 ++++++++++++++++++++++
>>  1 files changed, 22 insertions(+), 0 deletions(-)
> 
> We're not supposed to have platform data dependent to stuff in
> staging under arch/arm or anyplace else in the main kernel tree.
> 
> Please move this to
> drivers/staging/iio/adc/at91adc-board.h
> or so.

Won't moving this part to staging prevent from using this structure in
board files ? If so, how will I be able to declare a new board that is
using this ADC (or add the support for the ADC to a new one) ?

> As for calling the at91_add_device_adc() function (which I guess
> you want to do at some point) the pattern I followed for other
> drivers is to declare a dummy function in arch/arm/mach-*
> with __weak and let the staging driver override that. This way
> the staging driver can go away without any compilation trouble
> happening.

I don't really see why my changes will break the compilation if the
driver is no longer present in staging. At worst, the structure will be
filled but used by no one, right ?

Regards,

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
