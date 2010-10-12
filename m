From: mikpe@it.uu.se (Mikael Pettersson)
Date: Tue, 12 Oct 2010 10:47:29 +0200
Subject: [BUG] 2.6.36-rc6 on kirkwood breaks gcc precompiled-headers
Message-ID: <19636.8353.699455.193582@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've entered <http://gcc.gnu.org/bugzilla/show_bug.cgi?id=45979>
in gcc bugzilla, which is about gcc precompiled-headers tests
failing with the 2.6.36-rc6 kernel, but working with 2.6.35 and
older kernels.  gcc trunk and 4.4 release branch are affected,
haven't bothered checking 4.5.

I'm starting a kernel bisection to try to identify the cause of
this regression.  For now all I can say is that

- 2.6.36-rc6 on kirkwood (ts119) causes the breakage
- 2.6.35 and earlier are Ok on kirkwood and iop32x (n2100)

I haven't seen these gcc test failures with 2.6.36-rc kernels on
{x86,sparc64,ppc64,alpha}, so it looks ARM or kirkwood specific.

/Mikael
