From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Mar 2013 16:26:53 +0000
Subject: [PATCH 4/6] arm: vt8500: Remove gpio devicetree nodes
In-Reply-To: <CACRpkdYbtH7jJqmXT-SHKy8qbzbNntSwnJwS1+PR7brTJ3ijiw@mail.gmail.com>
References: <1362807578-23089-1-git-send-email-linux@prisktech.co.nz>
 <1362807578-23089-5-git-send-email-linux@prisktech.co.nz>
 <CACRpkdYbtH7jJqmXT-SHKy8qbzbNntSwnJwS1+PR7brTJ3ijiw@mail.gmail.com>
Message-ID: <201303131626.53571.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 March 2013, Linus Walleij wrote:
> > -               gpio: gpio-controller at d8110000 {
> > -                       compatible = "via,vt8500-gpio";
> > -                       gpio-controller;
> > -                       reg = <0xd8110000 0x10000>;
> > -                       #gpio-cells = <3>;
> > -               };
> 
> Whopeedo. If I understand the fine devicetree folks you may
> remove this stuff from the devicetree, but the code in the new
> pin control driver should still be backward-compatible with
> devicetrees that look like this.
> 
> It's not like I care, just noting that this is the philosophy around
> such things.

Right. For brand new code that does not have a lot of users, we can
be more pragmatic though. If you are sure enough that it does not
break for any existing users, we can change the binding. This may
well be the case for vt8500.

	Arnd
