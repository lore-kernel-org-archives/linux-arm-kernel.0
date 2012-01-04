From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 4 Jan 2012 10:20:41 +0800
Subject: [PATCH v3 1/3] pinctrl: enable pinmux for mmp series
In-Reply-To: <CACRpkdbvta3chYeMS=J94ehaOcEXp1OBnU74qSSCAO--PbehLg@mail.gmail.com>
References: <1324541855-19911-1-git-send-email-haojian.zhuang@marvell.com>
 <1324541855-19911-2-git-send-email-haojian.zhuang@marvell.com>
 <CACRpkdbvta3chYeMS=J94ehaOcEXp1OBnU74qSSCAO--PbehLg@mail.gmail.com>
Message-ID: <CAN1soZwhd=1bsKumvYg0hw9m-kRNb6Mio7GzOFk-d3dZZ-+pXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 1, 2012 at 10:15 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Dec 22, 2011 at 9:17 AM, Haojian Zhuang
> <haojian.zhuang@marvell.com> wrote:
>
>> Support PXA168/PXA910/MMP2 pinmux. Now only support function switch.
>
> (...)
>
>> +config PINCTRL_PXA3xx
>> + ? ? ? bool
>> + ? ? ? select PINMUX
>> +
>
> Good,
>
>> +config PINMUX_MMP2
>> + ? ? ? bool "MMP2 pinmux driver"
>> + ? ? ? depends on ARCH_MMP
>> + ? ? ? select PINCTRL_PXA3xx
>> + ? ? ? select PINCONF
>> +
>> +config PINMUX_PXA168
>> + ? ? ? bool "PXA168 pinmux driver"
>> + ? ? ? depends on ARCH_MMP
>> + ? ? ? select PINCTRL_PXA3xx
>> + ? ? ? select PINCONF
>> +
>> +config PINMUX_PXA910
>> + ? ? ? bool "PXA910 pinmux driver"
>> + ? ? ? depends on ARCH_MMP
>> + ? ? ? select PINCTRL_PXA3xx
>> + ? ? ? select PINCONF
>> +
>
> Please rename these PINCTRL_* too.
>

Changed file according to all comments in another patch series.

Thanks
Haojian
