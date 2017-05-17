From: davidm@egauge.net (David Mosberger)
Date: Wed, 17 May 2017 17:27:20 -0600
Subject: crash after receiving SIGCHLD during system call
In-Reply-To: <20170517230236.GK22219@n2100.armlinux.org.uk>
References: <CALnQHM3wjH1CWwUUJX7KhGOOhoW-0r22nyBWmBUJYCUFe-JEtw@mail.gmail.com>
 <20170517170940.GJ22219@n2100.armlinux.org.uk>
 <CALnQHM0tUDkjbX+oBW5pEeuBWUoX2eOmA9Qrc9V2-RsnDV3d6Q@mail.gmail.com>
 <20170517230236.GK22219@n2100.armlinux.org.uk>
Message-ID: <CALnQHM2ocw5ETbwsRF_c43tweHruunOjsfaBOT5Qxgt2K6Ww1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ah, yes, that makes sense now.  Thanks for decoding this properly!

It does look like rt_sigreturn is being used:

--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=4909,
si_uid=33, si_status=0, si_utime=1, si_stime=2} ---
rt_sigreturn()                          = 0

Rather disconcerting this problem.  I'll keep digging...

  --david
