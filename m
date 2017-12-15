From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 15 Dec 2017 11:16:43 -0200
Subject: WARNING: suspicious RCU usage
In-Reply-To: <20171215063817.GX7829@linux.vnet.ibm.com>
References: <20171210113930.zimywmxzsutwzzmz@linux-u7w5.ap.freescale.net>
 <20171210120012.GM10595@n2100.armlinux.org.uk>
 <20171210190727.GJ7829@linux.vnet.ibm.com>
 <20171210193438.GP10595@n2100.armlinux.org.uk>
 <20171210213930.GL7829@linux.vnet.ibm.com>
 <20171212164900.GA6673@linux.vnet.ibm.com>
 <CAOMZO5AftAWz339Sy+oxQ8K9Dr04Jyf8SV0R0JGrcPaL-VQLMQ@mail.gmail.com>
 <20171212173450.GD10595@n2100.armlinux.org.uk>
 <CAOMZO5DBMpCHfgmNND6=qJD+sxOLMPFqEsyz+GiBVhMzN3H+Zg@mail.gmail.com>
 <20171213091245.GH10595@n2100.armlinux.org.uk>
 <20171215063817.GX7829@linux.vnet.ibm.com>
Message-ID: <CAOMZO5Cte467YdvOvg_teuKdP435nFd0_t1j6Mxtax43GqMqYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Fri, Dec 15, 2017 at 4:38 AM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:

> For your amusement, I have a patch below that takes a paranoid view of
> the possible answers to these questions.  This patch is untested and
> probably does not even build.  Plus its polling loop is quite naive.

I tried to build it, but if fails to link:

  LD      vmlinux.o
  MODPOST vmlinux.o
arch/arm/kernel/smp.o: In function `__cpu_die':
smp.c:(.text+0x44c): undefined reference to `__bad_xchg'
Makefile:1024: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

Thanks
