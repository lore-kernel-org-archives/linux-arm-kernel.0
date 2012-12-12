From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Wed, 12 Dec 2012 23:26:59 +0100
Subject: [PATCH] drivers/pinctrl: grab default handles from device core
In-Reply-To: <CACRpkdbCuTAwqFVWkb7bx7_OAX_0PU8TjjbS879Ui30bdxXkQg@mail.gmail.com>
References: <1355233246-16694-1-git-send-email-linus.walleij@stericsson.com>
 <20121211181336.GD25714@kroah.com>
 <CACRpkdbCuTAwqFVWkb7bx7_OAX_0PU8TjjbS879Ui30bdxXkQg@mail.gmail.com>
Message-ID: <10768446.F2JLuVrZNU@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, December 12, 2012 08:56:41 PM Linus Walleij wrote:
> On Tue, Dec 11, 2012 at 7:13 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Tue, Dec 11, 2012 at 02:40:46PM +0100, Linus Walleij wrote:
> >> diff --git a/include/linux/device.h b/include/linux/device.h
> 
> >> +#ifdef CONFIG_PINCTRL
> >> +     struct dev_pin_info     pins;
> >> +#endif
> >
> > Can't you just make this a * to the structure, saving a bit of space for
> > those that don't use this structure?  Ok, it's only saving one pointer,
> > so it's really not a big deal to me if you don't want to do this, just
> > asking...
> 
> OK I'll look into it.

I wonder if you could use a struct that will be empty if CONFIG_PINCTRL is
unset instead of using #ifdef around the field like this?  [Kind of along the
lines of what I did for ACPI.]

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
