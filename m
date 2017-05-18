From: davidm@egauge.net (David Mosberger)
Date: Wed, 17 May 2017 23:34:57 -0600
Subject: crash after receiving SIGCHLD during system call
In-Reply-To: <CALnQHM2ocw5ETbwsRF_c43tweHruunOjsfaBOT5Qxgt2K6Ww1g@mail.gmail.com>
References: <CALnQHM3wjH1CWwUUJX7KhGOOhoW-0r22nyBWmBUJYCUFe-JEtw@mail.gmail.com>
 <20170517170940.GJ22219@n2100.armlinux.org.uk>
 <CALnQHM0tUDkjbX+oBW5pEeuBWUoX2eOmA9Qrc9V2-RsnDV3d6Q@mail.gmail.com>
 <20170517230236.GK22219@n2100.armlinux.org.uk>
 <CALnQHM2ocw5ETbwsRF_c43tweHruunOjsfaBOT5Qxgt2K6Ww1g@mail.gmail.com>
Message-ID: <CALnQHM1WpXmvkK8eCqd8G=6Ny-O=PD=nSaa1kwQBAB6dNwa1Hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So even with turning on all Errata workarounds, disabling the D-cache
and I-cache, and disabling branch prediction the problem still occurs.

I also confirmed that at the end of sys_rt_sigreturn(), the T bit in
regs->ARM_cpsr is NEVER set.

  --david
