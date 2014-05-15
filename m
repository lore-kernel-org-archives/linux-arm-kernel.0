From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 15 May 2014 13:08:17 +0100
Subject: [PATCH v6 03/15] irq: gic: support hip04 gic
In-Reply-To: <4785954.cZxbGoHV0t@wuerfel>
References: <1399795571-17231-1-git-send-email-haojian.zhuang@linaro.org>
 <1399795571-17231-4-git-send-email-haojian.zhuang@linaro.org>
 <53748A2B.9050304@arm.com> <4785954.cZxbGoHV0t@wuerfel>
Message-ID: <CAMJs5B82awFv7SV9RBu__t4_42PhR95VGPjS3LzWa2saDQReZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 May 2014 12:14, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 15 May 2014 10:34:35 Marc Zyngier wrote:
>> > +static inline bool gic_is_standard(struct gic_chip_data *gic)
>>
>> Please loose all of the inlines. The compiler can do this by itself.
>>
>> > +{
>> > +       return (gic->nr_cpu_if == 8);
>> > +}
>> > +
>
> I think it's actually the common style to spell out the 'inline'
> for trivial helpers like this. The compiler doesn't need it, but
> it also doesn't hurt and most people write it.
>
Only in header files, no?

I've been chastised previously for putting this in .c files.

-Christoffer
