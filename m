From: carlo@caione.org (Carlo Caione)
Date: Fri, 11 Apr 2014 11:26:54 +0200
Subject: [linux-sunxi] Re: [PATCH v3 01/10] mfd: AXP20x: Add mfd driver
 for AXP20x PMIC
In-Reply-To: <20140328092154.GF17779@lee--X1>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
 <1395955764-18103-2-git-send-email-carlo@caione.org>
 <20140328092154.GF17779@lee--X1>
Message-ID: <CAOQ7t2a4FbkuboTJWT=rpAVnq6a_mo7j58Dr9Rkg_yiHCuzbBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 10:21 AM, Lee Jones <lee.jones@linaro.org> wrote:

[...]

>> +static struct resource axp20x_pek_resources[] = {
>> +     {
>> +             .name   = "PEK_DBR",
>> +             .start  = AXP20X_IRQ_PEK_RIS_EDGE,
>> +             .end    = AXP20X_IRQ_PEK_RIS_EDGE,
>> +             .flags  = IORESOURCE_IRQ,
>> +     }, {
>> +             .name   = "PEK_DBF",
>> +             .start  = AXP20X_IRQ_PEK_FAL_EDGE,
>> +             .end    = AXP20X_IRQ_PEK_FAL_EDGE,
>> +             .flags  = IORESOURCE_IRQ,
>> +     },
>> +};
>
> Have you considered doing this in the Device Tree? It's a lot less
> code/overhead.

Hi Lee,
in v4 (I will send it soon) I left this code in since the resources
are well managed by the MFD core and adding it in the DT results in
pretty much the same code/overhead (atm the input device is not
present in the DT).
If you really think that it is the case to move the code in the DT,
please comment it in the v4.

Thanks,

-- 
Carlo Caione
