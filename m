From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 15 Dec 2017 18:36:49 -0200
Subject: WARNING: suspicious RCU usage
In-Reply-To: <20171215182340.GA30443@linux.vnet.ibm.com>
References: <20171210193438.GP10595@n2100.armlinux.org.uk>
 <20171210213930.GL7829@linux.vnet.ibm.com>
 <20171212164900.GA6673@linux.vnet.ibm.com>
 <CAOMZO5AftAWz339Sy+oxQ8K9Dr04Jyf8SV0R0JGrcPaL-VQLMQ@mail.gmail.com>
 <20171212173450.GD10595@n2100.armlinux.org.uk>
 <CAOMZO5DBMpCHfgmNND6=qJD+sxOLMPFqEsyz+GiBVhMzN3H+Zg@mail.gmail.com>
 <20171213091245.GH10595@n2100.armlinux.org.uk>
 <20171215063817.GX7829@linux.vnet.ibm.com>
 <CAOMZO5Cte467YdvOvg_teuKdP435nFd0_t1j6Mxtax43GqMqYw@mail.gmail.com>
 <20171215155218.GB7829@linux.vnet.ibm.com>
 <20171215182340.GA30443@linux.vnet.ibm.com>
Message-ID: <CAOMZO5C2Mo4VQ2WNDqcXbsu=uP=3suAhPzXd3-LSwbir38A22g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Fri, Dec 15, 2017 at 4:23 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:

> How about this one, also untested etc.?

This one gives a build warning:

arch/arm/kernel/smp.c: In function ?__cpu_die?:
arch/arm/kernel/smp.c:262:5: warning: ?ret? may be used uninitialized
in this function [-Wmaybe-uninitialized]
  if (!ret) {
     ^

but when I run suspend/resume I don't see the RCU warning with this
patch applied.

Thanks
