From: david@lechnology.com (David Lechner)
Date: Wed, 16 Mar 2016 12:58:34 -0500
Subject: [PATCH 2/5] ARM: davinci: da8xx: add usb phy clocks
In-Reply-To: <56E95128.5000607@cogentembedded.com>
References: <1458081473-8223-1-git-send-email-david@lechnology.com>
 <1458081473-8223-2-git-send-email-david@lechnology.com>
 <56E95128.5000607@cogentembedded.com>
Message-ID: <56E99ECA.90400@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/16/2016 07:27 AM, Sergei Shtylyov wrote:
>>
>> +static struct clk usb20_clk = {
>> +    .name        = "usb20",
>> +    .parent        = &pll0_sysclk2,
>> +    .lpsc        = DA8XX_LPSC1_USB20,
>> +    .gpsc        = 1,
>> +};
>
>     Why move it?

For organization, to keep all of the USB clocks together. I can leave it 
alone if that is preferred.

>> +
>> +    /* Set the mux depending on the parent clock. */
>> +    if (clk->parent == &pll0_aux_clk)
>> +        val |= CFGCHIP2_USB2PHYCLKMUX;
>> +    else if (clk->parent == &usb_ref_clk)
>> +        val &= ~CFGCHIP2_USB2PHYCLKMUX;
>
>     Don't we have clk_set_parent()for that?

Yes. clk_set_parent() is already called in a loop for all clocks 
elsewhere, so not needed here.

---

Thank you for the careful review. I will address the other problems you 
pointed out.
