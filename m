From: Claudiu.Beznea@microchip.com (Claudiu Beznea)
Date: Thu, 22 Feb 2018 19:42:29 +0200
Subject: [PATCH v3 06/10] pwm: add PWM modes
In-Reply-To: <CAHp75Ver6GuKSDooAr2DW+eqt=B3p8O+X6+rOSWNgfhHxgVqNQ@mail.gmail.com>
References: <1519300881-8136-1-git-send-email-claudiu.beznea@microchip.com>
 <1519300881-8136-7-git-send-email-claudiu.beznea@microchip.com>
 <CAHp75Ver6GuKSDooAr2DW+eqt=B3p8O+X6+rOSWNgfhHxgVqNQ@mail.gmail.com>
Message-ID: <e5090740-520a-34c0-6b52-09cc8ada11b1@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 22.02.2018 19:28, Andy Shevchenko wrote:
> On Thu, Feb 22, 2018 at 2:01 PM, Claudiu Beznea
> <claudiu.beznea@microchip.com> wrote:
>> Add PWM normal and complementary modes.
> 
>> +- PWM_DTMODE_COMPLEMENTARY: PWM complementary working mode (for PWM
>> +channels two outputs); if not specified, the default for PWM channel will
>> +be used
> 
> What DT stands for?
It stands for Device Tree. It remained this way from the previous version. In
the previous version I had modes described in an enum, to be used by PWM core,
as follows:
enum pwm_mode {
	PWM_MODE_NORMAL,
	PWM_MODE_COMPLEMENTARY,
};

and, to avoid conflict b/w these defines and the one from
include/dt-bindings/pwm/pwm.h I introduced this DT in the define names from
dt-bindings. But now the DT might be removed since I've changed the way the PWM
mode is identified in PWM core. I will remove the DT in the next version, if not
requested otherwise.

Thank you,
Claudiu Benea
