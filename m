From: arve@android.com (=?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?=)
Date: Mon, 14 Dec 2009 22:48:01 -0800
Subject: GPIO support for HTC Dream
In-Reply-To: <20091214064545.GK5114@elf.ucw.cz>
References: <20091208102842.GH12264@elf.ucw.cz>
	<20091208214658.GC4164@elf.ucw.cz> <4B1ECEEE.3000209@bluewatersys.com>
	<4B203575.6050407@bluewatersys.com>
	<20091210172458.GJ19454@elf.ucw.cz>
	<4B2150B7.3040207@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901FB0F92@mi8nycmail19.Mi8.com>
	<20091211221015.GB24456@elf.ucw.cz>
	<BD79186B4FD85F4B8E60E381CAEE190901FB10EA@mi8nycmail19.Mi8.com>
	<20091214064545.GK5114@elf.ucw.cz>
Message-ID: <d6200be20912142248n67cf020fw2bda313febe90fb9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 13, 2009 at 10:45 PM, Pavel Machek <pavel@ucw.cz> wrote:
>> > +int __init dream_init_gpio(void)
>> > +{
>> > + ? ? ? ?int i;
>> > +
>> > + ? ? ? ?for (i = 0; i < ARRAY_SIZE(msm_gpio_banks); i++)
>> > + ? ? ? ? ? ? ? ?gpiochip_add(&msm_gpio_banks[i].chip);
>> > +
>> > + ? return 0;
>> > +}
>>
>> Your original patch was initially writing the shadow values to the registers.
>> Do you still need to do that?
>
> It seems to boot this way :-). If writing the shadow values is not
> needed, lets try getting away without it...

I may boot this way, but unless you know that the bootloader
initialized all the registers to the same value, some outputs will be
in the wrong state until someone writes to a gpio in the same bank.

-- 
Arve Hj?nnev?g
