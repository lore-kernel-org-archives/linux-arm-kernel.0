From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Jan 2014 11:15:02 +0100
Subject: device-tree: at91: irq and gpios: problem while requesting a gpio
 used as an interrupt source.
In-Reply-To: <CACh+v5OOx8LgGVN0GFsa5-f=h1kasJVz4r0CfBXdXhK0F8iQAQ@mail.gmail.com>
References: <CACh+v5Os_FHh39oXGt=srw0s7bVkpnpH0pQ4ugit_k5BL_k-0A@mail.gmail.com>
 <52D3C166.5050908@overkiz.com>
 <20140115180615.GJ9558@ns203013.ovh.net>
 <52D79E51.4030300@overkiz.com> <52D7BCAA.30706@atmel.com>
 <CACh+v5OOx8LgGVN0GFsa5-f=h1kasJVz4r0CfBXdXhK0F8iQAQ@mail.gmail.com>
Message-ID: <CACRpkdap7mhGyAr6WcM-cOzbKBJp6S-Qi+oDoM-Pwos14SGyyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 1:02 PM, Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:

> Linus,
>  the root of the issue is the fact that a GPIO can't be requested
> twice. But IMO it's safe for a single device to request it more than
> once and use it for different purposes (irq and electrical signal
> value). Maybe we can rework the GPIO request to include this ownership
> information. I can post a draft implementation for this if you think
> it's worthwhile.

You are right and actually Jean-Christophe's patch is a good
start.

You also need to use the gpio_lock_as_irq() API as shown in
other patches to the subsystem e.g. this.
commit eb7cce1ea96b6399672abce787598f6e7a4352c3

Also check my other mail in this thread.

Yours,
Linus Walleij
