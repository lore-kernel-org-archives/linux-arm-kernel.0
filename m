From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 4 Dec 2014 11:24:48 +0000
Subject: [PATCH] ARM: kbuild: Fix forced rebuild after 'make dtbs'
In-Reply-To: <20141204112201.C824AC40992@trevor.secretlab.ca>
References: <CACRpkdYmJWy1_vs0tWRA7SvkQnvbXXKqf7pHpH5b5tZ6vR+KJg@mail.gmail.com>
 <1414961549-31666-1-git-send-email-jason@lakedaemon.net>
 <5474F78F.2060906@suse.cz>
 <20141125235150.GH3836@n2100.arm.linux.org.uk>
 <20141126005710.GE22670@titan.lakedaemon.net>
 <CACRpkdZJoWbQeuZ4ZXGbQr0+SNG_9ZA+cQkAA0C2F9rnZDYtyQ@mail.gmail.com>
 <20141126144153.GK3836@n2100.arm.linux.org.uk>
 <CACRpkdYwQT3+RLxP_b_kYJoHV4L7sZ7yiU=JZWVq_zHKz0EY_g@mail.gmail.com>
 <547C7364.8000009@suse.cz>
 <20141204112201.C824AC40992@trevor.secretlab.ca>
Message-ID: <20141204112448.GN11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 04, 2014 at 11:22:01AM +0000, Grant Likely wrote:
> On Mon, 01 Dec 2014 14:55:48 +0100, Michal Marek <mmarek@suse.cz> wrote:
> > Still, the dependency on the 'prepare' target is superfluous, if the
> > only requirement is that $(KERNELRELEASE) be set properly.
> 
> So, I've lost track of where things stand on this issue. What is the
> current proposed fix? Make dtbs depend on 'scripts' and dtbs_install
> depend on 'prepare scripts'? Or is there a better way to make sure
> KERNELRELEASE is set for the dtbs_install target?

Marek's first reply in the thread contains the solution:

  if you only need
  the KERNELRELEASE variable, then you do not need to depend on prepare.
  The main Makefile makes sure that silentoldconfig is ran and therefore
  KERNELRELEASE set for all targets except make *config.

which seems to suggest that "prepare" is not needed for either target.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
