From: Stephen.Beckwith@lsi.com (Beckwith, Stephen (Stephen))
Date: Thu, 17 Sep 2009 08:47:27 -0400
Subject: Problems with pthread on ARM/PXA270
In-Reply-To: <200909170935.31570.schindele@nentec.de>
References: <200909160926.02036.schindele@nentec.de>
	<200909161701.16898.schindele@nentec.de>
	<f17812d70909160806l5e4ce5e9t4c7cfea5ca714b91@mail.gmail.com>
	<200909170935.31570.schindele@nentec.de>
Message-ID: <8A7F3A77D8BF9540ACA37A8B8BD36A7353F3B189@palmail02.lsi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings All,
  I will quickly add the following to this thread, as it seems related.
Platform:
  Custom ARM9 SoC using Montavista Linux Release 3.1, a 2.4.21 Linux Kernel.  Montavista tool chain and libraries.

Problem:
  When we try and execute a pthread_create, "when loaded as a .so", the thread will be created, but will not "return" to the main thread for further processing, we basically get "stuck" in this  new thread.  In the "real" case, this is an ISR thread, would hang on waiting for an interrupt.  For testing, I use Sleep and prints to document program flow.
   However, IF I use the "exact same code" and build the program as an application, it works just fine dandy. . .   The thread gets spawned, prints it's initial hello, then goes into the while (1) sleep/print incrementing value loop.  The thread returns to the "Main" and we spawn 2 more threads and they work just fine (based upon interleaving printouts)

NOTE:
  For our "normal" development we use an external host processor (PowerPC based) to control the SoC and the ability to create threads from a .so has worked in this setup (using same MVL 3.1 kernel/toolchain) for the past 4+ years on 10's of platforms. So we suspected some issue/problem with the MVL setup


Now, we are migrating to a new ARM11 based SoC and I am in the process of re-testing this functionality.  
This new platform will be based upon 2.6.28 kernel release and CodeSourcery G++ Lite 2008q3-72 tools/libraries.
I'm in the process of setting this up on an ARM RealView EB.  

Details to follow.

Regards,
Stephen Beckwith


-----Original Message-----
From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of Juergen Schindele
Sent: Thursday, September 17, 2009 3:36 AM
To: linux-arm-kernel at lists.infradead.org
Cc: Eric Miao
Subject: Re: Problems with pthread on ARM/PXA270

Am Mittwoch, 16. September 2009 schrieb Eric Miao:
> On Wed, Sep 16, 2009 at 11:01 PM, Juergen Schindele <schindele@nentec.de> wrote:
> > Am Mittwoch, 16. September 2009 schrieb Eric Miao:
> >> Don't remember we had such problems before. What kind of system
> >> and libraries are you using?
> > thanks for your reply.
> > System is custom PXA270 platform.
> > with codesourcery compiler (see below)
> > and glibc 2.5 with pthread.
> > I dont know what more information to give ?
> 
> Like which kernel version, where do you get the glibc-2.5 and pthread binary,
Sorry forgot that completely !
Kernel version tested is 2.6.16 and 2.6.20 (sorry no newer version available yet)
Compiler , GlibC, pthread all come from Codesourcery precompiled in a package
 "CodeSourcery Sourcery G++ Lite 2007q1-10" downloadable for free.
Compiler version is as mentioned before :
arm-none-linux-gnueabi-gcc (CodeSourcery Sourcery G++ Lite 2007q1-10) 4.2.0 20070413 (prerelease)
 
--------------------------------------------------------------
J?rgen Schindele  
Software-Entwicklung

NENTEC Netzwerktechnologie GmbH
Greschbachstr. 12
76229 Karlsruhe
Deutschland
Telefon: +49 721 94249-51
Telefax: +49 721 94249-10
E-Mail:  schindele at nentec.de
WEB:     www.nentec.de
 
Gesch?ftsf?hrung: Klaus Becker, Roland Knapp
Sitz der Gesellschaft: Karlsruhe
Handelsregister: Amtsgericht Mannheim HRB 107658
--------------------------------------------------------------

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
