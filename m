From: b.brezillon@overkiz.com (boris brezillon)
Date: Fri, 29 Nov 2013 16:30:23 +0100
Subject: [PATCH 5/9] ARM: at91/dt: add mmc0 slot0 support to at91rm9200ek
 board
In-Reply-To: <CACRpkdag5=QYsWe81ocpkMp2APaoBAOOn2r0iAVdf9DHTKrSXA@mail.gmail.com>
References: <1377687640-10529-1-git-send-email-b.brezillon@overkiz.com>	<1377687995-10758-1-git-send-email-b.brezillon@overkiz.com>	<20131120145926.GE14627@ns203013.ovh.net>	<528CDFFB.1020601@overkiz.com>	<CACRpkdboBg4YOnMNiar0DDBVnoky=zNky+Pzyp1=P_POtH15qQ@mail.gmail.com>	<528DE1C4.6060900@overkiz.com>	<CACRpkdZdweyWJefttiuiYAJ9qhahLbnj7eHUiLV_83UA41X_uQ@mail.gmail.com>	<5294D64D.7000100@overkiz.com>	<CACRpkdZoAjuWVpWZfvPgOAd7qB1ZBtC+45nD3SYay3SrMhqwVA@mail.gmail.com>	<52986CA8.3010601@overkiz.com>
 <CACRpkdag5=QYsWe81ocpkMp2APaoBAOOn2r0iAVdf9DHTKrSXA@mail.gmail.com>
Message-ID: <5298B30F.3060905@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/11/2013 14:31, Linus Walleij wrote:
> On Fri, Nov 29, 2013 at 11:30 AM, boris brezillon
> <b.brezillon@overkiz.com> wrote:
>> On 29/11/2013 11:03, Linus Walleij wrote:
>>> I guess one way is to obtain this GPIO in board code and just
>>> flick it depending on which device you register.
> (...)
>> The whole goal of moving from board files to dt is to drop all board
>> specific processing or initialization and only keep a common description
>> with generic drivers capable of handling common use cases.
>>
>> I'm not sure providing new board specific drivers is a good solution
>> (even if it is the simplest way to achieve our goal).
>>
>> Could we have something similar to pinctrl but with gpios :
>> when the device is probed the device/driver core code request the gpio
>> configure it appropriately and set it to the requested value (if configured
>> as output).
> This has been suggested under the name "GPIO hogs" in the past.
>
> It would work similar to how pinctrl hogs work by associating the
> GPIO line the controller itself, using some specific string
> like gpio-input-hogs = <...> / gpio-output-hogs = <...>;
>
> The gpiolib core will then grab and set up these before
> returning from the registration call so noone ever gets a chance
> to use them.

Ok, I'll take a look.

Could you point me out a thread (or other documents) talking about gpio 
hogs.
I found this one 
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/162254.html.

>> These are just thoughts, and I guess introducing new code in the
>> device/driver core
>> code is not that easy, especially when this code is here to handle specific
>> case
>> like ours.
> It is very easy, just write the patch, iterate it (these patches get
> a lot of scrutiny as it is core code, so expect some work and time
> to get it done), and then unless there is a blocker, I would merge it.
> The concept is entirely sound, just that someone needs to step
> up and do the work...

Sure, I'll propose something (I guess your talking about GPIO hogs 
concept not gpio-switch driver).
If you already thought a bit about GPIO hogs, I'd be interested to get 
some inputs (suggestions, ideas, code, ...).

Anyway, thanks for taking time to answer my questions.

Best Reagrds,

Boris

> Yours,
> Linus Walleij
