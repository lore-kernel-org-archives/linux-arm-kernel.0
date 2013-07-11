From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 11 Jul 2013 20:54:51 +0530
Subject: [PATCH] clk: samsung: add set_rate and round_rate callbacks for
 pll45xx
In-Reply-To: <CAKew6eV0QP31gJNB2waeSRB5DN5Vs+mXO5bwaD5TiHYZvrANQA@mail.gmail.com>
References: <1373534869-12034-1-git-send-email-thomas.abraham@linaro.org>
 <CAKew6eV0QP31gJNB2waeSRB5DN5Vs+mXO5bwaD5TiHYZvrANQA@mail.gmail.com>
Message-ID: <CAJuYYwSSQ49Tp17Kja9sZgnibYR7UDrvSpoyPUs0i6GC6j2qeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yadwinder,

Thanks for your comments.

On 11 July 2013 16:14, Yadwinder Singh Brar <yadi.brar01@gmail.com> wrote:
> Hi Thomas,
>
> On Thu, Jul 11, 2013 at 2:57 PM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
>> Add support for set_rate and round_rate callbacks for pll45xx pll. This allows
>> configuring pll45xx to generate a desired clock output.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>>
>> The set_rate and round_rate callbacks in this patch for pll45xx are handled
>> slightly differently from the way it is done in the (not yet merged) patch
>> series from Yadwinder
>> (http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg19540.html)
>>
>> In this patch, the pll lookup table is kept as part of the pll configuration
>> code itself, since the pll is just a hardware block which takes an input
>> frequency and configuration values to genertate a output clock frequency.
>> Given a set of inputs, a pll of a given type will generate the same output
>> regardless of the SoC it is used in. So instead of supplying the pll lookup
>
> Tomasz also raised similar point earlier in discussion on that series.
> That time a question which remained unanswered for which we were waiting
> (as requested from hardware guys also) was that :
> Whether we need to stick to recommended values only or we can drive a
> particular output frequency with a given input frequency with any possible
> set of (P, M, S) values ?

The default lookup table could list all the possible target frequency
and its associated PMS values. Having a bigger list of PMS lookup
values should not matter since the CPUFreq driver would have a smaller
subset of frequency which can be selected on a particular SoC.

>
> Theoretically it seems possible but from manual its seems to prefer
> recommended values.
> Also I am not sure whether same values are always recommended in user manuals
> for different SoCs using same PLL type.
>
>> table from per-soc clock driver code (as done in the Yadwinder's patch series),
>> the pll lookup table can be coupled with the pll code itself, saving duplication
>> of pll lookup table for every SoC the pll is used with.
>
> If we don't need to stick to recommended table, definitely it will
> save lot of duplication.
> In-fact then we can use same pll lookup table for other PLLs also
> which have same calculation
> equation for output frequency.

Ok.

>
>
> Regards,
> Yadwinder

Thanks,
Thomas.

[...]
