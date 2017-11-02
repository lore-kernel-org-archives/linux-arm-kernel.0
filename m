From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 2 Nov 2017 11:35:37 -0400 (EDT)
Subject: [PATCH 3/3] ARM: early_printk: use printascii() rather than
 printch()
In-Reply-To: <SG2PR06MB116563CB4F1B55160392AAC68A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20171031171629.GI9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311346190.21665@knanqh.ubzr>
 <20171031175344.GJ9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311355000.21665@knanqh.ubzr>
 <20171031182024.GK9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311432120.21665@knanqh.ubzr>
 <SG2PR06MB1165AE45FB289039E55D03028A5E0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171102000945.GT9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1711012249020.21665@knanqh.ubzr>
 <SG2PR06MB11655BDEF09BB62D268A29DD8A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171102112041.GW9463@n2100.armlinux.org.uk>
 <SG2PR06MB11653D39086B1F58497C9FE08A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <nycvar.YSQ.7.76.1711021044380.21665@knanqh.ubzr>
 <SG2PR06MB116563CB4F1B55160392AAC68A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Message-ID: <nycvar.YSQ.7.76.1711021132170.21665@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 Nov 2017, Chris Brandt wrote:

> On Thursday, November 02, 2017 1, Nicolas Pitre wrote:
> > > > So, as far as ARM assembly in the Linux kernel goes, all constants
> > must
> > > > be preceded by # whether or not binutils requires it - no exceptions.
> > > > Please always test assembly changes with a binutils version that is
> > not
> > > > gratuitously broken!
> > >
> > > Somewhat ironic since Nicolas works for Linaro.
> > 
> > I'm not involved with the toolchain people though, other than using
> > their output.
> 
> That was the irony!
> 
> As in...
> Even if you built the code, you would have probably used a Linaro 
> toolchain and it would have worked like on my system.

Thing is... I *did* test it after I figured out I needed to turn off 
semihosting support. And the build failed.

>   Forget it.  (mailing lists are so dry when it comes to humor)

Life is tough.

> > They all fail, including the version that looks like the one you have.
> > 
> > Could you try that little test above on your side?
> 
> Yes, I also get a failure:
> 
> arm-linux-gnueabihf-as /tmp/t.s -o /tmp/t.o
> /tmp/t.s: Assembler messages:
> /tmp/t.s:2: Error: immediate expression requires a # prefix -- `mov r1,13'
> 
> But I think the answer is not that simple. 
> You have no command line options.

Would be good to figure out what option makes it accept no # and see if 
that can be avoided for kernel build.


Nicolas
