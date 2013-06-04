From: robherring2@gmail.com (Rob Herring)
Date: Tue, 4 Jun 2013 08:01:13 -0500
Subject: [PATCH 15/15] OF: remove #ifdef from linux/of_platform.h
In-Reply-To: <201306012257.02327.arnd@arndb.de>
References: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
 <201306012203.39133.arnd@arndb.de> <51AA59D0.7020805@gmail.com>
 <201306012257.02327.arnd@arndb.de>
Message-ID: <CAL_JsqKMOy4CM=FXbsy7mQ1f0DLyK6n_cuZ92uhsSM2Mq-3B1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 1, 2013 at 3:57 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 01 June 2013, Rob Herring wrote:
>> No, we still need empty functions. Here is what of_device.h looks like:
>>
>> http://tinyurl.com/l2azz5m
>>
>> BTW, it has your ack.
>>
>
> Could you add a patch on top that only puts the function declarations
> inside of #ifdef that don't have an inline wrapper?

I'm confused. You mean that DO have an inline? Like this:

void foo(void);

#ifdef CONFIG_OF
void bar(void);
#else
static inline void bar(void) {}
#endif

> It's really annoying to have to change the header file every time one
> needs to call a function from a driver in the DT-only case.

The functions without inlines are ones that drivers should not call
and should only be called from OF enabled code. That's why we have not
done a complete pass of adding inlines for everything.

Rob
