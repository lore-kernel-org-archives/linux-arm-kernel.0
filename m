From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 09 Oct 2014 06:25:29 -0700
Subject: [PATCH 01/44] kernel: Add support for poweroff handler call chain
In-Reply-To: <CAMuHMdVOBnZ=pyVeGSxbOT9MtRR2iNY4V-PUm0NU=UFQ2pxE_g@mail.gmail.com>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>	<1412659726-29957-2-git-send-email-linux@roeck-us.net>
 <CAMuHMdVOBnZ=pyVeGSxbOT9MtRR2iNY4V-PUm0NU=UFQ2pxE_g@mail.gmail.com>
Message-ID: <54368CC9.7020100@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/2014 04:31 AM, Geert Uytterhoeven wrote:
> On Tue, Oct 7, 2014 at 7:28 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>> +int register_poweroff_handler_simple(void (*handler)(void), int priority)
>> +{
>> +       char symname[KSYM_NAME_LEN];
>> +
>> +       if (poweroff_handler_data.handler) {
>> +               lookup_symbol_name((unsigned long)poweroff_handler_data.handler,
>> +                                  symname);
>> +               pr_warn("Poweroff function already registered (%s)", symname);
>> +               lookup_symbol_name((unsigned long)handler, symname);
>> +               pr_cont(", cannot register %s\n", symname);
>
> Doesn't %ps work to look up symbols?
>
> pr_warn("Poweroff function already registered (%ps), cannot register
> %ps\n", poweroff_handler_data.handler, handler);
>

Hi Geert,

That is great. One never stops learning. I'll use that.

Thanks!

Guenter
