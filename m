From: aletes.xgr@gmail.com (Alexandre Pereira da Silva)
Date: Tue, 17 Jul 2012 15:30:46 -0300
Subject: [PATCH RESEND] gpio: of_get_named_gpio_flags() return
 -EPROBE_DEFER if GPIO not yet available
In-Reply-To: <CACRpkdYBBa8BZMeGK0kiXNysn_ErpyKhTtbK8yFxf+JyMSndFw@mail.gmail.com>
References: <1340836334-20427-1-git-send-email-stigge@antcom.de>
 <CACRpkdYBBa8BZMeGK0kiXNysn_ErpyKhTtbK8yFxf+JyMSndFw@mail.gmail.com>
Message-ID: <CAAAP30FtFOQSJ8UvN6H+L6qwPyphi27L+mxi-3COu6RAJQTHcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 3:24 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Jun 28, 2012 at 12:32 AM, Roland Stigge <stigge@antcom.de> wrote:
>
>> of_get_named_gpio_flags() and of_get_named_gpio() return -EPROBE_DEFER if the
>> respective GPIO is not (yet) available. This is useful if driver's probe()
>> functions try to get a GPIO whose controller isn't probed yet. Thus, the driver
>> can be probed again later on.
>>
>> The function still returns -EINVAL on other errors (parse error or node doesn't
>> exist). This way, the case of an optional/intentionally missing GPIO is handled
>> appropriately.
>>
>> Signed-off-by: Roland Stigge <stigge@antcom.de>
>
> Patch applied, if all gpio stuff shall defer properly in v3.6 we need this
> so let's do some testing in -next!
>
> Would be nice to get some ACK besides my own...

You can add mine. I've been using this patch for quite some time now.

Acked-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

> Yours,
> Linus Walleij
