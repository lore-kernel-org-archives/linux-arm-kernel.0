From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 13 Nov 2014 09:16:48 +0100
Subject: [PATCH 2/4] simplefb: Add support for enumerating simplefb dt
 nodes in /chosen
In-Reply-To: <CAMuHMdWdtxcmDc7fDbQHfVa425sR3MGwJ70cRnh2Wb50iAo2CQ@mail.gmail.com>
References: <1415830124-28787-1-git-send-email-hdegoede@redhat.com>
 <1415830124-28787-2-git-send-email-hdegoede@redhat.com>
 <CAMuHMdWdtxcmDc7fDbQHfVa425sR3MGwJ70cRnh2Wb50iAo2CQ@mail.gmail.com>
Message-ID: <CAMuHMdWCF5+N3h890fUpPjAYWBEf6HcFEacz0j5GsLwNoF1Smw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 9:15 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Nov 12, 2014 at 11:08 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> --- a/drivers/video/fbdev/simplefb.c
>> +++ b/drivers/video/fbdev/simplefb.c
>
>> @@ -385,7 +386,37 @@ static struct platform_driver simplefb_driver = {
>>         .probe = simplefb_probe,
>>         .remove = simplefb_remove,
>>  };
>> -module_platform_driver(simplefb_driver);
>> +
>> +static int __init simplefb_init(void)
>> +{
>> +       int i, ret;
>
> unsigned int i;
>
>> +       char name[16];
>> +       struct device_node *np;
>> +
>> +       ret = platform_driver_register(&simplefb_driver);
>> +       if (ret)
>> +               return ret;
>> +
>> +       for (i = 0; ; i++) {
>> +               snprintf(name, sizeof(name), "framebuffer%d", i);

and %u, of course.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
