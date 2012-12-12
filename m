From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Dec 2012 20:56:41 +0100
Subject: [PATCH] drivers/pinctrl: grab default handles from device core
In-Reply-To: <20121211181336.GD25714@kroah.com>
References: <1355233246-16694-1-git-send-email-linus.walleij@stericsson.com>
 <20121211181336.GD25714@kroah.com>
Message-ID: <CACRpkdbCuTAwqFVWkb7bx7_OAX_0PU8TjjbS879Ui30bdxXkQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 11, 2012 at 7:13 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Dec 11, 2012 at 02:40:46PM +0100, Linus Walleij wrote:
>> diff --git a/include/linux/device.h b/include/linux/device.h

>> +#ifdef CONFIG_PINCTRL
>> +     struct dev_pin_info     pins;
>> +#endif
>
> Can't you just make this a * to the structure, saving a bit of space for
> those that don't use this structure?  Ok, it's only saving one pointer,
> so it's really not a big deal to me if you don't want to do this, just
> asking...

OK I'll look into it.

> Also, this will have to wait until after 3.8-rc1 before I can consider
> merging it, I'm a bit busy for the next two weeks at the least...

Sure. I'm mainly seeking an ACK so I can take it through the pinctrl
subsystem in any case, as I will probably stick a few dependencies
in there. And it'll certainly be for v3.9.

Yours,
Linus Walleij
