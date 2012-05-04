From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 May 2012 09:05:33 +0000
Subject: [PATCH 1/2] cs89x0_platform : Use ioread16/iowrite16 instead of
 inw/outw
In-Reply-To: <CAGzjT4cUPuwHQ-46saDWdFjweekWrYt7TTJMsUORGXd8FdLpLQ@mail.gmail.com>
References: <1335779839-30420-1-git-send-email-jaccon.bastiaansen@gmail.com>
 <201204301419.27119.arnd@arndb.de>
 <CAGzjT4cUPuwHQ-46saDWdFjweekWrYt7TTJMsUORGXd8FdLpLQ@mail.gmail.com>
Message-ID: <201205040905.33383.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 May 2012, Jaccon Bastiaansen wrote:
> So if I understand you correctly you would like to have an
> iopart_map() call in the cs89x0_probe() function and use the return
> value of that iopart_map() call as ioaddr parameter of the
> cs89x0_probe1() function. Is this correct? This would make the
> cs89x0_probe() function similar to the cs89x0_platform_probe()
> function where the return value of the ioremap() call is used as
> ioaddr parameter of the cs89x0_probe1() function.

Correct. Currently the code relies on some platforms defining
the inw/outw functions to the same thing as readw/writew, which
is not a correct behaviour. If we change it to always use
ioread16/iowrite16, it will be correct in either case.

> But why do you want to convert the current 16 bit accesses in the
> #else path to 32 bit accesses? Why not using ioread16()/iowrite16()?

Sorry, typo on my side, I meant ioread16/iowrite16.

	Arnd
