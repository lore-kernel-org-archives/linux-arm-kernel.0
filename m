From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 24 Nov 2011 12:44:08 -0200
Subject: [PATCH] mx28: added LRADC and touchscreen support
In-Reply-To: <20174.19732.607965.664497@ipc1.ka-ro>
References: <1322135394-4097-1-git-send-email-rusko.peter@prolan.hu>
 <20174.19732.607965.664497@ipc1.ka-ro>
Message-ID: <CAOMZO5BzmVvj1iupeLUTOdK+dw-zsuPLaG9VkYPXcX6EgdRgSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 11:56 AM, Lothar Wa?mann <LW@karo-electronics.de> wrote:

>> +static int lradc_freq = LRADC_CLOCK_6MHZ;
>> +
>> +static int __init lradc_freq_setup(char *str)
>> +{
>> + ? ? long freq;
>> +
>> + ? ? if (kstrtol(str, 0, &freq) < 0)
>> + ? ? ? ? ? ? return 0;
>> +
>> + ? ? if (freq < 0)
>> + ? ? ? ? ? ? return 0;
>> + ? ? if (freq >= 6)
>> + ? ? ? ? ? ? lradc_freq = LRADC_CLOCK_6MHZ;
>> + ? ? else if (freq >= 4)
>> + ? ? ? ? ? ? lradc_freq = LRADC_CLOCK_4MHZ;
>> + ? ? else if (freq >= 3)
>> + ? ? ? ? ? ? lradc_freq = LRADC_CLOCK_3MHZ;
>> + ? ? else if (freq >= 2)
>> + ? ? ? ? ? ? lradc_freq = LRADC_CLOCK_2MHZ;
>> + ? ? else
>> + ? ? ? ? ? ? return 0;
>> + ? ? return 1;
>> +}
>> +
>> +__setup("lradc_freq=", lradc_freq_setup);
>>
> How do you set lradc_freq when the driver is compiled as a module?
> module_param() would work for the driver compiled as a module as well
> as built-in

What about passing lradc_freq as platform data?
