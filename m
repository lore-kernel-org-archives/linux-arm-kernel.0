From: schindele@nentec.de (Juergen Schindele)
Date: Fri, 18 Sep 2009 12:06:59 +0200
Subject: Problems with pthread on ARM/PXA270
In-Reply-To: <20090916144051.GA19307@caradoc.them.org>
References: <200909160926.02036.schindele@nentec.de>
	<20090916144051.GA19307@caradoc.them.org>
Message-ID: <200909181206.59595.schindele@nentec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 16. September 2009 schrieb Daniel Jacobowitz:
> On Wed, Sep 16, 2009 at 09:26:01AM +0200, Juergen Schindele wrote:
> > Hello all,
> > we tried to implement a thread based software on our PXA270 based platform but
> > we had trouble with pthreads. So i modyfied a tiny progam to test. This little progam creates
> > 10 threads and each thread does print something (an index an a pointer to itself). 
> > 
> > On my PC with Suse 11.0 Linux (kernel 2.6.27) this works fine as supposed to.
> > Each thread has his turn and print his own values.
> > 
> > But on our pxa270 platform the thread switch does not (or really rarely) happen
> > and only one thread is printing always the same values. So i suppose thread
> > switching is not working!
> > 
> > Any hints or experiences are welcome !!!
> 
> It's just a wild guess, but check your sched_clock implementation.  I
> fixed a similar problem in QEMU last week; the kernel used to function
> OK with sched_clock always returning zero, but some time between
> 2.6.25 and 2.6.28 became dependent on it.
> 
sched_clock is apparently not implemented the same way in all kernel versions.
What about thread implementation in codesourcery compiler ? Are they 
"linux-threads" or "Native Posix thread library" or is it possible that there 
are important bugfixes til the version i use ???

Is my example app. correct in programming or am i doing bloody beginners mistake there ??

Thanks for your help 
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
 
Diese E-Mail enth?lt vertrauliche oder rechtlich gesch?tzte Informationen.
Wenn Sie nicht der vorgesehene Empf?nger sind, informieren Sie bitte sofort
den Absender und l?schen Sie diese E-Mail. Das unbefugte Kopieren dieser E-Mail
oder die unbefugte Weitergabe der enthaltenen Informationen ist nicht gestattet.
 
The information contained in this message is confidential or protected by law.
If you are not the intended recipient, please contact the sender and delete this
message. Any unauthorised copying of this message or unauthorised distribution of
the information contained herein is prohibited.
--------------------------------------------------------------
