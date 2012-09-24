From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Sep 2012 22:09:41 +0200
Subject: [PATCH v2] GPIO: Add support for GPIO on CLPS711X-target platform
In-Reply-To: <201209241829.22773.arnd@arndb.de>
References: <1348509352-19278-1-git-send-email-shc_work@mail.ru>
 <201209241829.22773.arnd@arndb.de>
Message-ID: <CACRpkdbdYBHEBAz25jKnAOaMsYSJR19g-YZOmVqT1pv95d6EsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2012 at 8:29 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 24 September 2012, Alexander Shiyan wrote:
>> +
>> +static const u32 clps711x_ports[] = {
>> +       _PADR, _PBDR, _PCDR, _PDDR, _PEDR,
>> +};
>> +
>> +static const u32 clps711x_pdirs[] = {
>> +       _PADDR, _PBDDR, _PCDDR, _PDDDR, _PEDDR,
>> +};
>> +
>> +static int gpio_clps711x_get(struct gpio_chip *chip, unsigned offset)
>> +{
>> +       return !!readb(clps711x_ports[chip->base / 8]) & (1 << offset);
>> +}
>
> In 3.7 and later, you won't be able to readb/writeb on an integer address,
> all addresses have to be of "void __iomem *" or compatible type.

OK that sounds like I can't merge this right now (but I like the
patch apart for this) so hold off for the 3.8 merge window, and
respin this on v3.7 as it comes out.

Yours,
Linus Walleij
