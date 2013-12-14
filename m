From: linux@roeck-us.net (Guenter Roeck)
Date: Sat, 14 Dec 2013 07:50:25 -0800
Subject: [PATCH v4 1/2] ARM: mach-moxart: add MOXA ART SoC platform files
In-Reply-To: <CACmBeS2_WZj6_HJo0N50TBwneNVmeB9TyXbHRLm9CJFGNN+HtQ@mail.gmail.com>
References: <1386945188-8316-1-git-send-email-jonas.jensen@gmail.com>	<1386945188-8316-2-git-send-email-jonas.jensen@gmail.com>	<201312131717.25435.arnd@arndb.de>	<CACmBeS0Uz+Z=MsqvXburO1swCdyGvEXHhfs8M7ZnMMKBNJjG1A@mail.gmail.com>	<20131213190707.GA9713@roeck-us.net>
 <CACmBeS2_WZj6_HJo0N50TBwneNVmeB9TyXbHRLm9CJFGNN+HtQ@mail.gmail.com>
Message-ID: <52AC7E41.7050201@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14/2013 12:32 AM, Jonas Jensen wrote:
> On 13 December 2013 20:07, Guenter Roeck <linux@roeck-us.net> wrote:
>>> I got the impression from Guenter Roeck's review, that it doesn't belong there,
>>> maybe I was too quick to remove it?
>>>
>> You'd have to answer the questions I raised in my review if you want it in
>> there.
>
> I didn't see a solution at the time. Now I'm thinking arm_pm_restart
> can be set later in probe, preventing a crash on load failure, and
> maybe it can be unset on unload.
>
> Would you accept a patch for this?
>

The above would at least avoid the crash, though I would not understand
the point of having an unloadable restart handler. Forcing the watchdog
driver into the kernel just because you want the restart handler in it
would seem odd. And if the restart handler is optional, why have it
in the first place ? I also don't follow Arnd's logic of wanting to have
the code in the watchdog driver just because it happens to use a register
that it needs.

Conceptually it might be cleaner to write a separate driver, for example
in drivers/power/restart, than plugging the functionality into
the watchdog driver, at least if you don't want it in architecture
or platform code. The xgene restart driver is a good example.

Anyway, it is not up to me to accept the code, that is up to Wim.
My rejection was primarily due to technical flaws, which can be addressed.
For the logical reasoning you'll have to convince Wim.

Guenter
