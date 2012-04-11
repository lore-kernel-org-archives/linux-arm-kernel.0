From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Apr 2012 09:59:25 +0200
Subject: [PATCH 2/2] dma/amba-pl08x: add support for the Nomadik variant
In-Reply-To: <4F83AC55.3070900@st.com>
References: <1334004816-20219-1-git-send-email-linus.walleij@linaro.org>
 <4F83AC55.3070900@st.com>
Message-ID: <CACRpkdaz9g7cRc1rAMHUzRbLcrYtB-kPCB6bFEMYZxxmWfLNSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 5:43 AM, Viresh Kumar <viresh.kumar@st.com> wrote:
> On 4/10/2012 2:23 AM, Linus Walleij wrote:

>> + ? ? ? ? ? ? ? ? ? ? val = readl(ch->base + PL080_CH_CONFIG);
>> + ? ? ? ? ? ? ? ? ? ? if (val & (PL080N_CONFIG_ITPROT | PL080N_CONFIG_SECPROT)) {
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? dev_info(&adev->dev, "physical channel %d reserved "
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"for secure access only\n", i);
>
> Better not to break the print string. Go beyond 80 columns.

OK

>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ch->locked = true;
>> + ? ? ? ? ? ? ? ? ? ? } else
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ch->locked = false;
>> + ? ? ? ? ? ? }
>> +
>
> Memory for ch is allocated with kmalloc and so its default value is garbage.
> So we must set locked to false in else part here.

Hm maybe better to kzalloc() the channel structs?

>> @@ -2036,9 +2069,9 @@ static struct amba_id pl08x_ids[] = {
>> ? ? ? },
>> ? ? ? /* Nomadik 8815 PL080 variant */
>> ? ? ? {
>> - ? ? ? ? ? ? .id ? ? = 0x00280880,
>> + ? ? ? ? ? ? .id ? ? = 0x00280080,
>
> Has this changed? How it worked earlier?

Never worked until now. It was based on incorrect data sheets...

I'll send a V2 ASAP.

Yours,
Linus Walleij
