From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 18 Apr 2016 15:39:25 +0200
Subject: [PATCH v5 03/11] soc: renesas: rcar-sysc: Add DT support for SYSC
 PM domains
In-Reply-To: <CAMuHMdW+PboSz-u2dV=rmNFkd4qsEhm-O_4Ewdn_-H62gwq7Ng@mail.gmail.com>
References: <1460558672-10290-1-git-send-email-geert+renesas@glider.be>
 <1460558672-10290-4-git-send-email-geert+renesas@glider.be>
 <CAPDyKFrQtX3-7GodrXV2zp4wHBgbWBOVKyE0XoeWaaxhZ2kUuw@mail.gmail.com>
 <CAMuHMdW+PboSz-u2dV=rmNFkd4qsEhm-O_4Ewdn_-H62gwq7Ng@mail.gmail.com>
Message-ID: <CAMuHMdUHPLRrOLO_qio80YHPye1tmrr=Fq9kpDg+Q0aVDycFiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Mon, Apr 18, 2016 at 2:59 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Apr 18, 2016 at 2:21 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> [...]
>>
>>> +
>>> +static bool rcar_sysc_active_wakeup(struct device *dev)
>>> +{
>>> +       return true;
>>
>> I am interested to know why this is always returning true. Perhaps you
>> can elaborate a bit on that?
>
> Too many copying from old shmobile PM Domain code?
> Honestly, I don't know...
>
> Perhaps Rafael still remembers the original rationale, as git history for
> commit e3e0109138376bb2 ("ARM / shmobile: Support for I/O power domains for
> SH7372 (v9)") doesn't have it.
>
> Google did find: https://lkml.org/lkml/2011/6/30/471
>
> Do we still need this at all? I.e. aren't PM Domains containing wake-up
> devices kept powered automatically during system suspend?

No they aren't. So for pm-rmobile we do need it.

For rcar-sysc it's different: as no PM Domain contains wake-up devices
(all I/O devices are in the always-on power area), we don't need the callback.
Will drop it in v6.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
