From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 21 Oct 2015 15:58:44 +0200
Subject: [GIT PULL 3/6] KVM: arm: use GIC support unconditionally
In-Reply-To: <9140096.cYCnE2rDUr@wuerfel>
References: <1445357947-6022-1-git-send-email-christoffer.dall@linaro.org>
 <1445357947-6022-4-git-send-email-christoffer.dall@linaro.org>
 <672714208.55851501.1445370665940.JavaMail.zimbra@zmail13.collab.prod.int.phx2.redhat.com>
 <9140096.cYCnE2rDUr@wuerfel>
Message-ID: <20151021135844.GB13488@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2015 at 03:45:20PM +0200, Arnd Bergmann wrote:
> On Tuesday 20 October 2015 15:51:05 Paolo Bonzini wrote:
> > Should this be "select" or "depends on"? Not a blocker, can always be fixed in 4.4.
> 
> We have lots of 'select ARM_GIC' in the tree for platforms that use one, using
> 'depends on' will limit KVM support to being available only if at least one
> of them is being used.
> 
> The only platform I can think of that uses ARMv7ve without actually having
> a GIC is BCM2836 (Raspberry Pi 2). Can we actually run KVM on a platform
> like that? If so, 'depends on' might be better, otherwise let's stay with
> 'select'.

Yes you can, just without the VGIC and the timer - you have to emulate
that in userspace.  Samsung also has a broken platform where they
integrated things incorrectly, so you cannot use the VGIC, but that
platform support is out of tree, so I can't see if it uses the GIC in
general or not.

I'm a bit confused why using 'depends on' in this case helps anythign?

(I know, I suck at dealing with the config system)

Thanks,
-Christoffer
