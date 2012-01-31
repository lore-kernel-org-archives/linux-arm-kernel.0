From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Tue, 31 Jan 2012 11:06:50 +0100
Subject: [PATCH 07/21] OMAP3+: PM: SR/Class3: disable errorgen before
 disable VP
In-Reply-To: <4F213860.9050600@ru.mvista.com>
References: <1327504583-13408-1-git-send-email-j-pihet@ti.com>
 <1327504583-13408-8-git-send-email-j-pihet@ti.com>
 <4F213860.9050600@ru.mvista.com>
Message-ID: <CAORVsuUNM8bpwyjbG2GcwfiUEf7A54ODC4tfhZNinUhQTE3g5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei,

On Thu, Jan 26, 2012 at 12:26 PM, Sergei Shtylyov
<sshtylyov@ru.mvista.com> wrote:
> Hello.
>
>
> On 25-01-2012 19:16, Jean Pihet wrote:
...

>> Change-Id: Id0145adacfa63d7652a29859ad6c95cc2ac61cc8
> ? Please remove this line.
Done!

...

>> +int sr_disable_errgen(struct voltagedomain *voltdm)
>> +{
>> + ? ? ? u32 errconfig_offs, vpboundint_en;
>> + ? ? ? u32 vpboundint_st;
>> + ? ? ? struct omap_sr *sr = _sr_lookup(voltdm);
>> +
>> + ? ? ? if (IS_ERR(sr)) {
>> + ? ? ? ? ? ? ? pr_warning("%s: omap_sr struct for sr_%s not found\n",
>> + ? ? ? ? ? ? ? ? ? ? ? __func__, voltdm->name);
>> + ? ? ? ? ? ? ? return -EINVAL;
>
>
> ? Not PTR_ERR(sr)?
_sr_lookup returns a return code using ERR_PTR so the return value
should be checked for errors using IS_ERR. Please note that _sr_lookup
checks for NULL parameter internally.

BTW in the next revision of patches (just submitted) there is an
additional patch [19/19] that fixes a few problems related to the use
of err.h macros.

>
> WBR, Sergei

Regards,
Jean
