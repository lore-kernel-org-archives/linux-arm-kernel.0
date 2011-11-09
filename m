From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 Nov 2011 13:31:44 +0100
Subject: [PATCH 4/6] spi/pl022: skip default configuration before
 suspending
In-Reply-To: <4EBA5C08.1040709@st.com>
References: <1320835154-31303-1-git-send-email-linus.walleij@stericsson.com>
 <4EBA5C08.1040709@st.com>
Message-ID: <CACRpkdZLPnM-NqOOz3OjwCzKys9LvEt0Yxej4JMf4GCjfB_kyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 9, 2011 at 11:55 AM, Viresh Kumar <viresh.kumar@st.com> wrote:
> On 11/9/2011 4:09 PM, Linus WALLEIJ wrote:
>>
>> - ? ? amba_vcore_enable(pl022->adev);
>> - ? ? amba_pclk_enable(pl022->adev);
>> - ? ? load_ssp_default_config(pl022);
>> - ? ? amba_pclk_disable(pl022->adev);
>> - ? ? amba_vcore_disable(pl022->adev);
>> - ? ? dev_dbg(dev, "suspended\n");
>> + ? ? dev_dbg(&adev->dev, "suspended\n");
>
> why adev->dev instead of dev?

Plain bug. It doesn't even compile with -DDEBUG :-/

I'll fix it up..

Linus
