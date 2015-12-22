From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Dec 2015 09:50:58 +0100
Subject: [PATCH v2] pinctrl: at91-pio4: use %pr format string for resource
In-Reply-To: <2376227.VpCVZMP4nr@wuerfel>
References: <5199877.GVYeflqET9@wuerfel>
 <CACRpkdZ4F8Loyoh6niCvkM=S8KcekTs8EvXRmB-0WxcRFw_8+g@mail.gmail.com>
 <2376227.VpCVZMP4nr@wuerfel>
Message-ID: <CACRpkdZwBjFDpHPPRWxoQ=NgQ68ABAxEsB1RCi3nsY1p33UUJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 4:29 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 30 November 2015 09:47:03 Linus Walleij wrote:
>> On Wed, Nov 18, 2015 at 4:21 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> > resource_size_t may be defined as 32 or 64 bit depending on configuration,
>> > so it cannot be printed using the normal format strings, as gcc correctly
>> > warns:
>> >
>> > pinctrl-at91-pio4.c: In function 'atmel_pinctrl_probe':
>> > pinctrl-at91-pio4.c:1003:41: warning: format '%u' expects argument of type 'unsigned int', but argument 5 has type 'resource_size_t {aka long long unsigned int}' [-Wformat=]
>> >    dev_dbg(dev, "bank %i: hwirq=%u\n", i, res->start);
>> >
>> > This changes the format string to use the special "%pr" format
>> > string that prints a resource, and changes the arguments so we
>> > the resource structure directly.
>> >
>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> > ---
>> > v2: don't break ordering of arguments, that part was correct already, unlike
>> > what I said in v1.
>>
>> Patch applied with Ludovic's review tag.
>
> I don't see this in linux-next, did the commit get lost accidentally?

No, it's just that I screwed up the next branch so many times and
Stephen has not been able to pull it into linux-next.

Hope it works now...

Linus Walleij
