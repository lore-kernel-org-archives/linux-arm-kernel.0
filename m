From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Thu, 23 Jul 2015 14:04:24 +0530
Subject: [PATCH v6 03/13] clk: qcom: gdsc: Use PM clocks to control gdsc
 clocks
In-Reply-To: <55B03CE9.4050903@codeaurora.org>
References: <1437549069-29655-1-git-send-email-rnayak@codeaurora.org>
 <1437549069-29655-4-git-send-email-rnayak@codeaurora.org>
 <55B03CE9.4050903@codeaurora.org>
Message-ID: <55B0A710.9080209@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2015 06:31 AM, Stephen Boyd wrote:
> On 07/22/2015 12:10 AM, Rajendra Nayak wrote:
>> @@ -104,6 +105,37 @@ static int gdsc_disable(struct generic_pm_domain
>> *domain)
>>       return gdsc_toggle_logic(sc, false);
>>   }
>> +static int gdsc_attach(struct generic_pm_domain *domain, struct
>> device *dev)
>> +{
>> +    int ret;
>> +    struct gdsc *sc = domain_to_gdsc(domain);
>> +    char **con_id, *con_ids[] = { "core", "iface", NULL };
>
> const?
>
> This is where I get scared of sniffing too much SoC glue. What's to
> enforce the "core", and "iface" naming scheme? What's to enforce there
> being two clocks vs. one? Maybe a better approach would be to use
> of_clk_get() and iterate through all clocks of the device, or to encode
> the clock names in the gdsc structure.

I had the clock names in the gdsc structure in v5. I should probably go
back to having it that way.
