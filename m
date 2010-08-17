From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 17 Aug 2010 11:06:15 +0200
Subject: [RFC] new ATAG for NVS?
In-Reply-To: <AANLkTikMoc+QZnp2SeX2AJMCMF=FYVdWgQOri0cxTvkw@mail.gmail.com>
References: <AANLkTikMoc+QZnp2SeX2AJMCMF=FYVdWgQOri0cxTvkw@mail.gmail.com>
Message-ID: <AANLkTi=RhOJTVg8UhMUxkgR-pNJXY4kcjUeE53CM-yFT@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/13 Vitaly Wool <vitalywool@gmail.com>:

> we're currently thinking over how to pass over the data from
> non-volatile storage to a kernel driver. I've seen some examples in
> kernel that actually read out the NV data to userspace and then supply
> it as firmware to the driver that requests it. However, if NV data is
> anyway processed by the bootloader, isn't it reasonable to pass it
> over to kernel via ATAG? I'm eager to come up with a patch that
> introduces new ATAG for that.

What kind of data is it and where is it stored?

I remember seeing some people adding extensions to e.g. the
RTC drivers to read out the NVRAM found in some RTC chips,

Isn't it possible to just export the symbol from e.g. the RTC driver
and provide it in a header file like include/linux/rtc/foo.h
int get_foo_nvram_array(char *ramcontents, maxlength);
or something like that?

Or is there some other restriction like reading it is slow or
in some security context so that only the bootloader can
access it?

Yours,
Linus Walleij
