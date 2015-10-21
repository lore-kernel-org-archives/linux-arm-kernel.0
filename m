From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Oct 2015 15:45:20 +0200
Subject: [GIT PULL 3/6] KVM: arm: use GIC support unconditionally
In-Reply-To: <672714208.55851501.1445370665940.JavaMail.zimbra@zmail13.collab.prod.int.phx2.redhat.com>
References: <1445357947-6022-1-git-send-email-christoffer.dall@linaro.org>
 <1445357947-6022-4-git-send-email-christoffer.dall@linaro.org>
 <672714208.55851501.1445370665940.JavaMail.zimbra@zmail13.collab.prod.int.phx2.redhat.com>
Message-ID: <9140096.cYCnE2rDUr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 October 2015 15:51:05 Paolo Bonzini wrote:
> Should this be "select" or "depends on"? Not a blocker, can always be fixed in 4.4.

We have lots of 'select ARM_GIC' in the tree for platforms that use one, using
'depends on' will limit KVM support to being available only if at least one
of them is being used.

The only platform I can think of that uses ARMv7ve without actually having
a GIC is BCM2836 (Raspberry Pi 2). Can we actually run KVM on a platform
like that? If so, 'depends on' might be better, otherwise let's stay with
'select'.

Note that ARM_GIC is not a user-visible option, you can only turn it on
by picking one or more platforms that have a GIC.

	Arnd
