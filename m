From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 5 Nov 2012 13:37:00 +0100
Subject: [PATCH 2/2] Input: nomadik-ske-keypad - start using the apb_pclk
In-Reply-To: <CAPDyKFpjdVMCuBdN-O+xxK=Dko-GTEjF5AYOeEMgWghJfB8EsA@mail.gmail.com>
References: <1351779602-13818-1-git-send-email-ulf.hansson@stericsson.com>
 <1351779602-13818-3-git-send-email-ulf.hansson@stericsson.com>
 <CACRpkdbZB4nhFQtLH-GxBSK99RFk7yhSYMhO5keVjyugrqr7JA@mail.gmail.com>
 <CAPDyKFpjdVMCuBdN-O+xxK=Dko-GTEjF5AYOeEMgWghJfB8EsA@mail.gmail.com>
Message-ID: <CACRpkdZv0+Q1ohD7KMV5+nAkFrz+esWNHtV1EhtWz7Nrzcnt8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 5, 2012 at 1:25 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 4 November 2012 19:12, Linus Walleij <linus.walleij@linaro.org> wrote:

>> If I understand correctly, the only "real" solution is to
>> implement the PM domains and have these enable the clocks.
>
> Agree.
>
> Although, since the pm_domain not yet exist, this as a way forward for
> now - to fix what is broken.

True. Fixing regressions is more important.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

> When the pm_domain is in place and when we decide to fold in the clock
> handling in there, we can move it.

OK for me.

>> An alternative may be to move this driver over to the AMBA bus,
>> because I think this device actually has primecell registers.
>> Then the bus will take care of the pclk for starters.
>
> You are definitely right, this driver can be converted into using the AMBA bus.
> Although, do you think that should be done _instead_ of going ahead
> with this patch or do you want that to be handled as a next and a
> separate step?

No, just a suggestion of possibilities...

Yours,
Linus Walleij
