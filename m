From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 25 Apr 2016 10:30:14 +0200
Subject: [PATCH v6 05/11] soc: renesas: rcar-sysc: Enable Clock Domain for
 I/O devices
In-Reply-To: <CAMuHMdVb46Get_+e0FzYhJMCwat-YaEDOcgFKqyGhtVBTOdJ8A@mail.gmail.com>
References: <1461153766-750-1-git-send-email-geert+renesas@glider.be>
 <1461153766-750-6-git-send-email-geert+renesas@glider.be>
 <CAPDyKFqcDDq-FGd9-PgJmig-Csqrj6LxqKtm1pMf1fq-LtGKvw@mail.gmail.com>
 <CAMuHMdVb46Get_+e0FzYhJMCwat-YaEDOcgFKqyGhtVBTOdJ8A@mail.gmail.com>
Message-ID: <CAPDyKFq0mXp24LoJX1AbaDV8=mhpapQy6Dz-SZNfvETs8ZZr4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 April 2016 at 09:59, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulf,
>
> On Fri, Apr 22, 2016 at 9:28 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> @@ -217,6 +218,8 @@ static int rcar_sysc_pd_power_on(struct generic_pm_domain *genpd)
>>>         return rcar_sysc_power_up(&pd->ch);
>>>  }
>>>
>>> +static bool has_cpg_mstp;
>>> +
>>
>> That's seems lazy. :-)
>>
>> Sure you can provide this as an input parameter to
>> rcar_sysc_pd_setup() instead, no?
>
> This variable is intended to go away, once all R-Car SoCs have been converted
> to use the CPG/MSSR driver, and has_cpg_mstp will always be false.
> Then we can just remove those lines, instead of reworking the parameter
> passing.

Okay, that seems like a reasonable way forward.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
