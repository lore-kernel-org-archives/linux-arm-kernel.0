From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 6 Nov 2012 15:39:03 +0100
Subject: [PATCH v3 9/9] pinctrl: single: dump pinmux register value
In-Reply-To: <CAN1soZxVp73uNWD7Q9r_3X1hCA=JhMiMpx2UMPPGiXBtQ2QjAA@mail.gmail.com>
References: <1351724661-29050-1-git-send-email-haojian.zhuang@gmail.com>
 <1351724661-29050-10-git-send-email-haojian.zhuang@gmail.com>
 <20121101004734.GK15766@atomide.com>
 <CAN1soZxVp73uNWD7Q9r_3X1hCA=JhMiMpx2UMPPGiXBtQ2QjAA@mail.gmail.com>
Message-ID: <CACRpkdZXfOqUM+-NCSzLJ40pP8gc9k6mx=zAjnPyrgGXckrWDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 1, 2012 at 6:48 AM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
> On Thu, Nov 1, 2012 at 1:47 AM, Tony Lindgren <tony@atomide.com> wrote:

>>>  static void pcs_pin_dbg_show(struct pinctrl_dev *pctldev,
>>>                                       struct seq_file *s,
>>> -                                     unsigned offset)
>>> +                                     unsigned pin)
>>>  {
>>>       struct pcs_device *pcs;
>>> -     unsigned val;
>>> +     unsigned val, mux_bytes;
>>>
>>>       pcs = pinctrl_dev_get_drvdata(pctldev);
>>>
>>> -     val = pcs->read(pcs->base + offset);
>>> -     val &= pcs->fmask;
>>> +     mux_bytes = pcs->width / BITS_PER_BYTE;
>>> +     val = pcs->read(pcs->base + pin * mux_bytes);
>>>
>>>       seq_printf(s, "%08x %s " , val, DRIVER_NAME);
>>>  }
>>> --
>>> 1.7.10.4
>>>
>
> There's also include a bug fix. I'm OK that this patch could be
> included in -rc cycle.

A debug print can by definition not be a regression, it
should not have a specific use other than debugging.

And those debugging can use linux-next or separate
patches or whatever ... better keep this series together.

Yours,
Linus Walleij
