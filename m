From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 16 Mar 2016 21:04:11 +0300
Subject: [PATCH 2/5] ARM: davinci: da8xx: add usb phy clocks
In-Reply-To: <56E99ECA.90400@lechnology.com>
References: <1458081473-8223-1-git-send-email-david@lechnology.com>
 <1458081473-8223-2-git-send-email-david@lechnology.com>
 <56E95128.5000607@cogentembedded.com> <56E99ECA.90400@lechnology.com>
Message-ID: <56E9A01B.3010503@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/16/2016 08:58 PM, David Lechner wrote:

>>> +static struct clk usb20_clk = {
>>> +    .name        = "usb20",
>>> +    .parent        = &pll0_sysclk2,
>>> +    .lpsc        = DA8XX_LPSC1_USB20,
>>> +    .gpsc        = 1,
>>> +};
>>
>>     Why move it?
>
> For organization, to keep all of the USB clocks together. I can leave it alone
> if that is preferred.

    I'd prefer to minimize the noise...

>>> +
>>> +    /* Set the mux depending on the parent clock. */
>>> +    if (clk->parent == &pll0_aux_clk)
>>> +        val |= CFGCHIP2_USB2PHYCLKMUX;
>>> +    else if (clk->parent == &usb_ref_clk)
>>> +        val &= ~CFGCHIP2_USB2PHYCLKMUX;
>>
>>     Don't we have clk_set_parent()for that?
>
> Yes. clk_set_parent() is already called in a loop for all clocks elsewhere, so
> not needed here.

    No, I mean why is not this implemented as a part of clk_set_parent()?

MBR, Sergei
