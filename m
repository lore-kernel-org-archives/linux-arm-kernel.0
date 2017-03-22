From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 22 Mar 2017 11:23:24 +0100
Subject: [PATCH 1/5] clk: meson: Add support for parameters for specific
 PLLs
In-Reply-To: <149013981400.54062.11268768959465562064@resonance>
References: <1489411604-18700-1-git-send-email-narmstrong@baylibre.com>
 <1489411604-18700-2-git-send-email-narmstrong@baylibre.com>
 <149013981400.54062.11268768959465562064@resonance>
Message-ID: <f8dbb772-90c9-b98f-d237-4b773188faf5@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2017 12:43 AM, Michael Turquette wrote:
> Quoting Neil Armstrong (2017-03-13 06:26:40)
[..]
>>  
>>         p = &pll->n;
>> -       ret = meson_clk_pll_wait_lock(pll, p);
>> +       /* If unreset_for_lock is provided, remove the reset bit here */
>> +       if (pll->params.unreset_for_lock) {
> 
> Small nitpick, but I find "unreset" to be confusing. Since 'reset' here
> is a bit that can be set and unset, maybe use clear_reset_for_lock
> instead?
> 
> Regards,
> Mike
> 

You are right, I'll rename it.

Neil
