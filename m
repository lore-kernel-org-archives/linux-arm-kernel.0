From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Mar 2017 14:23:57 +0100
Subject: [PATCH v2 4/6] bus: add driver for the Technologic Systems NBUS
In-Reply-To: <82dfdbb8-58fc-45b4-685c-98be11341e45@savoirfairelinux.com>
References: <20170203194729.20995-1-sebastien.bourdelin@savoirfairelinux.com>
 <20170203194729.20995-5-sebastien.bourdelin@savoirfairelinux.com>
 <CACRpkdYfGmVBYgAc4KZGN6634WM_EyzNj_SBbALEs4WYipXRQA@mail.gmail.com>
 <82dfdbb8-58fc-45b4-685c-98be11341e45@savoirfairelinux.com>
Message-ID: <CACRpkdbjANV+kiO_W9+=OL=fzPtTVwH2CpWDmNa50t3JaHTFkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2017 at 5:56 PM, Sebastien Bourdelin
<sebastien.bourdelin@savoirfairelinux.com> wrote:
> On 02/04/2017 05:14 AM, Linus Walleij wrote:

>>> +       gpiod_set_array_value_cansleep(gpios->ndescs, gpios->desc, values);
>>
>> This can also fail and you should check the return code and print an error
>> message if it does.
>>
> As far as i understood, the "gpiod_set_array_value_cansleep(...)"
> function doesn't return
> anything, it will return immediately if gpios->desc is null but nothing
> else.
> Did i miss something?

No I did, sorry about that.

We *should* make these functions return errors but currently they do not.

>> Error codes?
>>
> Same question here, these functions only make call to
> "gpiod_set_value_cansleep(...)",
> which as far as i understood doesn't return any error code.

Yeah, forget that.

>>> +               gpiod_set_value_cansleep(ts_nbus->csn, 1);
>>
>> Here too.
>>
> Same question, doesn't seem to have an error code.

That too.

Yours,
Linus Walleij
