From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Oct 2012 19:27:15 +0200
Subject: [PATCH RFC 02/11 v4] gpio: Add sysfs support to block GPIO API
In-Reply-To: <20121016164326.GA4858@kroah.com>
References: <1350343887-7344-1-git-send-email-stigge@antcom.de>
 <1350343887-7344-3-git-send-email-stigge@antcom.de>
 <20121015235720.GA3132@kroah.com> <507D58D9.2040607@antcom.de>
 <20121016164326.GA4858@kroah.com>
Message-ID: <CACRpkdYaaSt9uLN2_=KXYDK2b5D5paopsYxgYKqezKCx8cy=vQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2012 at 6:43 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Tue, Oct 16, 2012 at 02:53:45PM +0200, Roland Stigge wrote:
>>
>> Further, current gpio and gpiochip devices are also doing this way:
>> creating the device and subsequently their attrs, even though there may
>> be a better way but I'm still wondering how this would be.
>
> Then the existing code is broken and should be fixed to use dev_attrs.
> I guess it's time to audit the tree and find all places that get this
> wrong...

The thing is, as I've tried to explain but maybe didn't get across,
that these devices don't *have* a parent, and are not part of any
tree.

They are parentless mock devices, created on-the-fly just to get
sysfs entries.

What is needed it to get the device model right in the first
place.

Fixing it has been drafted by me and Grant:
https://blueprints.launchpad.net/linux-linaro/+spec/gpiochip-to-dev

This is not all-encompassing though :-/

Yours,
Linus Walleij
