From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 10 Oct 2009 22:06:59 +0800
Subject: [PATCH 1/2] PalmTreo: generalisation of Treo680 code
In-Reply-To: <200909131127.05790.marek.vasut@gmail.com>
References: <1252670222-25233-1-git-send-email-sleep_walker@suse.cz>
	<200909122129.06685.marek.vasut@gmail.com>
	<200909131103.38184.sleep_walker@suse.cz>
	<200909131127.05790.marek.vasut@gmail.com>
Message-ID: <f17812d70910100706r6bb37749ud15fd496fcd2fc28@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for late response. Applied to 'devel'.

On Sun, Sep 13, 2009 at 5:27 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Dne Ne 13. z??? 2009 11:03:37 Tom?? 'Sleep_Walker' ?ech napsal(a):
>> Hi,
>>
>> thanks for reading my patch!
>>
>> Dne So 12. z??? 2009 21:29:06 Marek Vasut napsal(a):
>> > ...
>> >
>> > > -static struct gpio_led_platform_data gpio_led_info = {
>> > > - .leds ? ? ? ? ? = gpio_leds,
>> > > - .num_leds ? ? ? = ARRAY_SIZE(gpio_leds),
>> > > +static struct gpio_led_platform_data treo680_gpio_led_info = {
>> > > + .leds ? ? ? ? ? = treo680_gpio_leds,
>> > > + .num_leds ? ? ? = ARRAY_SIZE(treo680_gpio_leds),
>> > > ?};
>> >
>> > Be careful so you dont run into symbol redefinition here (gpio_led_info)
>> > in case the kernel supports more than this one device ...
>>
>> That's why I change the name. It's called now 'treo680_gpio_led_info' as
>> ?you can see.
>>
>> > ...
>> >
>> > > +#endif /* CONFIG_MACH_TREO680 */
>> > > +
>> > > ?/* setup udc GPIOs initial state */
>> > > -static void __init treo680_udc_init(void)
>> > > +static void __init treo_udc_init(void)
>> > > ?{
>> > > - if (!gpio_request(GPIO_NR_TREO680_USB_PULLUP, "UDC Vbus")) {
>> > > - ? ? ? ? gpio_direction_output(GPIO_NR_TREO680_USB_PULLUP, 1);
>> > > - ? ? ? ? gpio_free(GPIO_NR_TREO680_USB_PULLUP);
>> > > + if (!gpio_request(GPIO_NR_TREO_USB_PULLUP, "UDC Vbus")) {
>> > > + ? ? ? ? gpio_direction_output(GPIO_NR_TREO_USB_PULLUP, 1);
>> > > + ? ? ? ? gpio_free(GPIO_NR_TREO_USB_PULLUP);
>> > > ? }
>> > > ?}
>> >
>> > Is this really needed or is it just a copy-paste from other Palm device?
>>
>> Unfortunately yes. There is no copy-paste in this code which wasn't checked
>> ?and tested. It doesn't work correctly without that.
>>
>> Best regards,
>>
>> Tomas Cech
>>
>
> Oh ok, you have my Ack on both then.
>
