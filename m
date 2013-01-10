From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Jan 2013 12:00:14 +0100
Subject: [PATCH v4 13/19] ARM: remove mach .handle_irq for VIC users
In-Reply-To: <201301032148.39523.arnd@arndb.de>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
 <1357235668-9450-14-git-send-email-robherring2@gmail.com>
 <201301032148.39523.arnd@arndb.de>
Message-ID: <CACRpkdYmZAx36K=QW_BHuhT9Y=KZyLw+7y6MeVBaVn13hbq1Sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 3, 2013 at 10:48 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 03 January 2013, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> Now that the VIC initialization sets up the handle_arch_irq pointer, we
>> can remove it for all machines and make it static.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> Cc: Ryan Mallon <rmallon@gmail.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Hubert Feurstein <hubert.feurstein@contec.at>
>> Cc: Alessandro Rubini <rubini@unipv.it>
>> Cc: STEricsson <STEricsson_nomadik_linux@list.st.com>
>> Cc: Ben Dooks <ben-linux@fluff.org>
>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>> Cc: Shiraz Hashim <shiraz.hashim@st.com>
>> Cc: Rajeev Kumar <rajeev-dlh.kumar@st.com>
>> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Acked-by: Jamie Iles <jamie@jamieiles.com>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
>> Acked-by: Olof Johansson <olof@lixom.net>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

And
Acked-by: Linus Walleij <linus.walleij@linaro.org>

>> +static void vic_handle_irq(struct pt_regs *regs);
>> +
>>  /**
>>   * vic_init2 - common initialisation code
>>   * @base: Base of the VIC.
>> @@ -466,7 +468,7 @@ static int handle_one_vic(struct vic_device *vic, struct pt_regs *regs)
>>   * Keep iterating over all registered VIC's until there are no pending
>>   * interrupts.
>>   */
>> -asmlinkage void __exception_irq_entry vic_handle_irq(struct pt_regs *regs)
>> +static asmlinkage void __exception_irq_entry vic_handle_irq(struct pt_regs *regs)
>>  {
>>         int i, handled;
>>
>
> I'm a big fan of the "no forward function declarations in .c files" rule. Can
> I convince to reorder the file contents instead to avoid the forward declaration?

And +1 on this comment.

Yours,
Linus Walleij
