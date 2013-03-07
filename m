From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 7 Mar 2013 04:25:28 +0100
Subject: [PATCH 2/2] pinctrl: imx: use pin_func_ids to search the pinctrl
 item.
In-Reply-To: <CAP1dx+xB0O2zouDcjmv3uO1Nk3EGytmAxn18tEO7EzXJOWoh8w@mail.gmail.com>
References: <1361932553-8218-1-git-send-email-b32955@freescale.com>
 <1361932553-8218-2-git-send-email-b32955@freescale.com>
 <CACRpkdYO5UN=t_nu1XQmBAjH6zWZRgnOY2zSQeO2K=ERrUPQCg@mail.gmail.com>
 <CAP1dx+xB0O2zouDcjmv3uO1Nk3EGytmAxn18tEO7EzXJOWoh8w@mail.gmail.com>
Message-ID: <CACRpkdYwyB1zC+ZgrJyiAnfEuH758f4q3J6LG-LT=WV25E9sRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 4, 2013 at 3:18 AM, Dong Aisheng <dong.aisheng@linaro.org> wrote:
> On 1 March 2013 21:07, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Wed, Feb 27, 2013 at 3:35 AM, Huang Shijie <b32955@freescale.com> wrote:
>>
>>> The uart may works in DTE mode or DCE mode. The customer can sets the different
>>> modes by the pinctrl. But the pinctrl items for DTE or DCE may share the
>>> same Pad id, such as:
>>>   MX6Q_PAD_EIM_D27__UART2_RXD_DTE and MX6Q_PAD_EIM_D27__WEIM_WEIM_D_27
>>>   share the same MX6Q_PAD_EIM_D27 pad id.
>>>
>>> The current code only search the pinctrl items by pad id. So if there two
>>> pinctrl items shares the same pad id, the current code only use the first one,
>>> even you tell the system to use the second one in the DTS file.
>>>
>>> This patch adds a new field pin_func_ids to imx_pin_group{}, and uses the
>>> pin_func_ids as the index to search the pinctrl items. In this way, we can
>>> avoid the issue.
>>>
>>> Signed-off-by: Huang Shijie <b32955@freescale.com>
>>
>> Dong/Shawn: what about this patch?
>
> We do not need this patch anymore since we've changed the binding a bit.

OK ignoring this then.

Yours,
Linus Walleij
