From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Jan 2018 10:39:32 +0100
Subject: [PATCH 3/4] bcm2835-gpio-exp: Driver for GPIO expander via
 mailbox service
In-Reply-To: <20180110034557.5sqpbsvt6ly6s2go@tarshish>
References: <cover.1514898134.git.baruch@tkos.co.il>
 <bcac00c71b29c359b59053a30d817a8f17d6731d.1514898134.git.baruch@tkos.co.il>
 <CACRpkdb73jGGRm5OrXLGYSOjMni-NsOwdC7TXH2k+iAEnAvL2g@mail.gmail.com>
 <20180110034557.5sqpbsvt6ly6s2go@tarshish>
Message-ID: <CACRpkdZWF+8dX6eOHDO+qv=ubwqxTx4MJphoOCX4130eaEqGMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 4:45 AM, Baruch Siach <baruch@tkos.co.il> wrote:
> Hi Linus,
>
> On Wed, Jan 03, 2018 at 11:08:15AM +0100, Linus Walleij wrote:
>> On Tue, Jan 2, 2018 at 2:19 PM, Baruch Siach <baruch@tkos.co.il> wrote:
>> > +#include <linux/err.h>
>> > +#include <linux/gpio.h>
>>
>> Just use
>>
>> #include <linux/driver.h>
>
> You mean linux/gpio/driver.h, right?

Yes.

> I still need linux/gpio.h for GPIOF_DIR_*.

Don't use these, just use 0 and 1 open coded for the
moment (if you check my devel branch, the references to
these flags are gone).

We need to make new defines for the new API.

Yours,
Linus Walleij
