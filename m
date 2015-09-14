From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 14 Sep 2015 14:21:11 -0700
Subject: [PATCH 3/3] ARM: brcmstb: Setup BIU control registers during boot
In-Reply-To: <20150914204833.GA53555@google.com>
References: <1442260369-6575-1-git-send-email-f.fainelli@gmail.com>
 <1442260369-6575-4-git-send-email-f.fainelli@gmail.com>
 <20150914204833.GA53555@google.com>
Message-ID: <55F73A47.9070900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/09/15 13:48, Brian Norris wrote:
> On Mon, Sep 14, 2015 at 12:52:49PM -0700, Florian Fainelli wrote:
>> Call brcmstb_biuctrl_init() in brcmstb's init_irq machine descriptor
>> callback since we need to setup the Bus Interface Unit before SMP in
>> particular, but we also need to be able to remap registers.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>> +static void __init brcmstb_init_irq(void)
>> +{
>> +	irqchip_init();
>> +	brcmstb_biuctrl_init();
> 
> I believe you're introducing a dependency on CONFIG_SOC_BRCMSTB, but
> it's not represented in Kconfig. Maybe SOC_BRCMSTB shouldn't be
> user-selectable, and it should just be select-ed by ARCH_BRCMSTB?

It is thanks to your previous commit, which is why I mentioned in the
cover letter that this was based on the 'soc/next' branch.

https://github.com/Broadcom/stblinux/commit/b19826efa15f94084416d5fc7749c45eabfbee36

Thanks for taking a look though!
-- 
Florian
