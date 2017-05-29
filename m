From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 May 2017 10:50:35 +0200
Subject: [PATCH V3 1/2] dt-bindings: pinctrl: add imx7ulp pinctrl binding
 doc
In-Reply-To: <AM3PR04MB3065626F1B45C8459E5765580FE0@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <1495539829-23345-1-git-send-email-aisheng.dong@nxp.com>
 <20170523182321.GA13664@w540>
 <AM3PR04MB3065626F1B45C8459E5765580FE0@AM3PR04MB306.eurprd04.prod.outlook.com>
Message-ID: <CACRpkdaQ0xn8mm6mCemf+dEtOqYgR5eLd296+8CfOOLy9CJ4BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 5:10 AM, A.S. Dong <aisheng.dong@nxp.com> wrote:

>> > +   NOTE: i.MX7ULP PIN_FUNC_ID consists of 4 integers as it shares one
>> mux
>> > +   and config register as follows:
>> > +   <mux_conf_reg input_reg mux_mode input_val>
>>
>> As your PIN_FUNC_ID specifies both the pin ids and their mux settings,
>> shouldn't you use the newly documented 'pinmux' property in place of
>> 'pins'?
>>
>> Please see
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/
>> ?id=8d5e7c5df0a6c442373628be5221321172b1badf
>>
>> The current documentation specifies pin ids and mux settings have to be
>> assembled in one single integer, which is not your case, but that can be
>> changed to make it accept an array of integers values if needed.
>>
>
> Thanks for the info.
> Looks good to me.
>
> Shawn & Linus,
> Are you okay with this?
>
> If yes, I can extend the standard 'pinmux' property to support integer array
> and renew the patch series to use it.

After reading Jacopo's commit it seems to make a lot of sense indeed,
so please do this.

Yours,
Linus Walleij
