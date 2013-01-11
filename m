From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Jan 2013 16:30:57 +0000
Subject: [PATCH] ARM: kernel: DT cpu map validity check helper function
In-Reply-To: <1357921058-11322-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1357921058-11322-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20130111163057.GE23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 04:17:38PM +0000, Lorenzo Pieralisi wrote:
> This patch implements a helper function that platforms can call to check
> whether DT based cpu map initialization and cores count were completed
> successfully.

Umm, are you sure this works?  Two problems here:
- the kernel boot marks the booting CPU (in our case, CPU0) as present,
  possible and online before arch code gets called.  smp_init_cpus()
  will be called with the maps already initialized per that.

- this really needs to be paired with a patch showing how you intend it
  to be used; merely adding the helper without any sign of it being used
  means it's just bloat which may not end up being used.
