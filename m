From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 May 2012 09:38:43 +0200
Subject: [PATCH 7.2/15] ARM: ux500: Disable SMSC911x platform code
 registration when DT is enabled
In-Reply-To: <4FB35343.4090407@linaro.org>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdZzAQNJ9ejKJJQJhEPjO9VO+fPHmPeCErg8XOj-dLc3gA@mail.gmail.com>
 <4F967986.6090808@linaro.org> <201205031257.52100.arnd@arndb.de>
 <CACRpkdaLG+LwNpKX_52+scLrNbezvRXEuCfF5CAb4XFOSD4xag@mail.gmail.com>
 <4FB35343.4090407@linaro.org>
Message-ID: <CACRpkdZziyAtUvDPhzvdhaUSFYQ5QjTEDJKWTQOaB4D+7A+qrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 9:12 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On 03/05/12 18:14, Linus Walleij wrote:

> In the pull request was:
>> @@ -612,7 +612,6 @@ static struct platform_device *snowball_platform_devs[] __initdata = {
(...)
> But this made it into arm-soc:
>> @@ -605,7 +605,6 @@ static void __init mop500_uart_init(struct device *parent)

Two exactly identical arrays just on different line numbers, yeah...

> Somehow the incorrect *_platform_devs[] was amended.
> Some kind of git automatic conflict resolution error?

Probably a patch -p1 < foo.patch error, that's the kind of stuff
it causes. My fault, certainly. The problem is that I don't see
the problem with git diff, it looks correct there too.

I thought that my bad branch had been replaced with a
different (correct) pull request from you though :-/

So how to we fix it? With an incremental patch on top?

Yours,
Linus Walleij
