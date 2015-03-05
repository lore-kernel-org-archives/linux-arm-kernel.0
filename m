From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 5 Mar 2015 09:44:55 +0100
Subject: preferable method for pinctrl driver
In-Reply-To: <54D88EC9.70409@rempel-privat.de>
References: <54379C10.3050004@rempel-privat.de>
 <CACRpkdYG6sNEfKNJBdbYCn4AbGiX2OfQAVJorR64cbB_gsWDbw@mail.gmail.com>
 <545C846C.6090502@rempel-privat.de>
 <545C9C41.1090300@rempel-privat.de>
 <CACRpkdZMX=HSpusLtPREufJpXuHOwH2MCtHrViASDR7Vbu_eMw@mail.gmail.com>
 <54D88EC9.70409@rempel-privat.de>
Message-ID: <CACRpkdarpb05emmf4xUpgyWua8U8ueoLWwEkJG2EtVK3w0RG6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 9, 2015 at 11:41 AM, Oleksij Rempel <linux@rempel-privat.de> wrote:

> What is preferred method of handling gpio_request_enable in pinctrl
> driver? My hw provide GPIO as one of mux variants for each controlled
> pin.  if i see it correctly, pin subsystem will not prevent using one
> pin as gpio and request for some other functionality? Should it be
> prevented by driver?

That is up to the driver writer. We have contemplated adding an
option to pinctrl_desc enforcing "exclusive GPIO" meaning that
GPIO and another mux setting cannot be used at the same time,
but noone got around to implementing that.

Some pin controllers can do GPIO and another function at the
same time, see illustrations and text in
Documentation/pinctrl.txt

Yours,
Linus Walleij
