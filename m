From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 22 Oct 2009 22:05:49 +0800
Subject: zaurus: cleanup sharpsl_pm.c
In-Reply-To: <f17812d70910200859v6d18e81bs2760d8af1d8da5bf@mail.gmail.com>
References: <20091006200339.GA1538@ucw.cz> <20091017163627.GB1423@ucw.cz>
	<f17812d70910200859v6d18e81bs2760d8af1d8da5bf@mail.gmail.com>
Message-ID: <f17812d70910220705o9f4a0ddwa22157b59a519350@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2009 at 11:59 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Sun, Oct 18, 2009 at 12:36 AM, Pavel Machek <pavel@ucw.cz> wrote:
>> On Tue 2009-10-06 22:03:39, Pavel Machek wrote:
>>> This fixes checkpatch/style problems in sharpsl_pm.c, allowing me to
>>> submit real fixes next. Move spitz-specific voltage table to
>>> spitz-specific file.
>>>
>>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>>
>> Eric, any news on this one? I have real development going on top of
>> this one, so it is quite important for me...
>
> Sorry late on this. Applied.

Pavel,

Here's the problem, please help look into this:

  CC      arch/arm/mach-pxa/corgi_pm.o
In file included from
/home/ycmiao/kernel/linux-2.6/arch/arm/mach-pxa/corgi_pm.c:28:
/home/ycmiao/kernel/linux-2.6/arch/arm/mach-pxa/include/mach/pxa2xx-gpio.h:4:2:
warning: #warning Please use mfp-pxa2[57]x.h instead of pxa2xx-gpio.h
/home/ycmiao/kernel/linux-2.6/arch/arm/mach-pxa/corgi_pm.c:217: error:
'spitz_battery_levels_noac' undeclared here (not in a function)
/home/ycmiao/kernel/linux-2.6/arch/arm/mach-pxa/corgi_pm.c:218: error:
'spitz_battery_levels_acin' undeclared here (not in a function)
make[2]: *** [arch/arm/mach-pxa/corgi_pm.o] Error 1
make[1]: *** [arch/arm/mach-pxa] Error 2
make[1]: *** Waiting for unfinished jobs....
