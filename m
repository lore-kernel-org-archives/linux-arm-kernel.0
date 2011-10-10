From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Oct 2011 10:17:01 +0200
Subject: [PATCH 2/2] pinmux: add a driver for the U300 pinmux
In-Reply-To: <CAGsJ_4yKzyFzJwKgA2nkUf6z2fYoQLB48SOJR82DyAvcut7khQ@mail.gmail.com>
References: <1317629883-13582-1-git-send-email-linus.walleij@stericsson.com>
	<CAGsJ_4yKzyFzJwKgA2nkUf6z2fYoQLB48SOJR82DyAvcut7khQ@mail.gmail.com>
Message-ID: <CACRpkdZ-WTecB-SPXjs531heu4M5Jc-9YvjEV2fPfaHSxiYG2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 8, 2011 at 11:09 AM, Barry Song <21cnbao@gmail.com> wrote:
>> +static void __init u300_pmx_dumpregs(struct u300_pmx *upmx)
>> +{
>> + ? ? ? u16 regval;
>> + ? ? ? int i;
>> +
>> + ? ? ? for (i = 0; i < ARRAY_SIZE(u300_pmx_registers); i++) {
>> + ? ? ? ? ? ? ? regval = readw(upmx->virtbase + u300_pmx_registers[i]);
>> + ? ? ? ? ? ? ? dev_info(upmx->dev, "PMX%u: 0x%04x\n", i, regval);
>> + ? ? ? }
>> +}
>
> is this a debug information or do you want it to be in mainline?

Debug info, I'll delete it. Not that it hurt, but I'll kill it.

>> +       /* Create state holders etc for this driver */
>> +       upmx = devm_kzalloc(&pdev->dev, sizeof(struct u300_pmx), GFP_KERNEL);
>
> and this would be "devm_kzalloc(&pdev->dev, sizeof(*upmx), GFP_KERNEL); " ?

Same semantic effect, but if you prefer it that way, sure :-)

I've seen both used in the kernel before...

Can I have your Reviewed-by: tag after this?

Linus Walleij
