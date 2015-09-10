From: r-woodruff2@ti.com (Woodruff, Richard)
Date: Thu, 10 Sep 2015 23:33:29 +0000
Subject: mysterious crashes on OMAP5 uevm
In-Reply-To: <20150910083026.GA21098@n2100.arm.linux.org.uk>
References: <CANOLnOO3NdK1r1jZQtS=TcHEE7SQwhGHh0YsqqoCJpFW3NO05Q@mail.gmail.com>
 <20150908143810.GD4215@atomide.com>
 <CANOLnOODjTaBcL1QzAm7o4YOB=_P-s7JYovu6fhNSqJSV2Bq+Q@mail.gmail.com>
 <20150908210708.GH4215@atomide.com>
 <E0068B56-0DEE-4E2F-94CF-DB104AE16D63@goldelico.com>
 <20150910083026.GA21098@n2100.arm.linux.org.uk>
Message-ID: <EF62F09C0797D947AD4180A1043C0DF740C21B4D@DLEE11.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Russell King - ARM Linux
 
> > >>>> There are 2 workarounds that I know which make the problem go
> > >>>> away (one is enough):
> > >>>> - recompile Xorg with -marm (I'm using Debian armhf so it's
> > >>>> thumb2 by default)
> > >>>> - disable ARCH_MULTI_V6 in the kernel config

This reminds me of a customer crash I saw quite a while ago relating to thumb2.  I thought it was fixed but maybe not.

In a couple spots the PSR_IT_MASK was not conditionally handled well in ARCH_MULTI_V6 flow.  Some stack sanity check failed and a BUG() was triggered.

Compiling the app for v6 or pulling MULTI from the kernel build solved the issue.

Additionally it was not handled correctly in GDB.   The old build of GDB didn't do MULTI and needed a hack to be useable on thumb2 code.

Regards,
Richard W.
