From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 24 Nov 2011 13:01:15 -0200
Subject: [PATCH] mx28: added LRADC and touchscreen support
In-Reply-To: <CAOMZO5BzmVvj1iupeLUTOdK+dw-zsuPLaG9VkYPXcX6EgdRgSw@mail.gmail.com>
References: <1322135394-4097-1-git-send-email-rusko.peter@prolan.hu>
 <20174.19732.607965.664497@ipc1.ka-ro>
 <CAOMZO5BzmVvj1iupeLUTOdK+dw-zsuPLaG9VkYPXcX6EgdRgSw@mail.gmail.com>
Message-ID: <CAOMZO5AnEb3hUQMT80jodG=CbkGbyWSLXrhDWzYXge5qH3iMZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter,

On Thu, Nov 24, 2011 at 12:44 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Thu, Nov 24, 2011 at 11:56 AM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
>
>>> +static int lradc_freq = LRADC_CLOCK_6MHZ;
>>> +
>>> +static int __init lradc_freq_setup(char *str)
>>> +{
>>> + ? ? long freq;
>>> +
>>> + ? ? if (kstrtol(str, 0, &freq) < 0)
>>> + ? ? ? ? ? ? return 0;
>>> +
>>> + ? ? if (freq < 0)
>>> + ? ? ? ? ? ? return 0;
>>> + ? ? if (freq >= 6)
>>> + ? ? ? ? ? ? lradc_freq = LRADC_CLOCK_6MHZ;
>>> + ? ? else if (freq >= 4)
>>> + ? ? ? ? ? ? lradc_freq = LRADC_CLOCK_4MHZ;
>>> + ? ? else if (freq >= 3)
>>> + ? ? ? ? ? ? lradc_freq = LRADC_CLOCK_3MHZ;
>>> + ? ? else if (freq >= 2)
>>> + ? ? ? ? ? ? lradc_freq = LRADC_CLOCK_2MHZ;
>>> + ? ? else
>>> + ? ? ? ? ? ? return 0;
>>> + ? ? return 1;
>>> +}
>>> +
>>> +__setup("lradc_freq=", lradc_freq_setup);
>>>
>> How do you set lradc_freq when the driver is compiled as a module?
>> module_param() would work for the driver compiled as a module as well
>> as built-in
>
> What about passing lradc_freq as platform data?

You can also look at this AT91 ADC driver patch for reference:
http://www.spinics.net/lists/arm-kernel/msg148461.html
