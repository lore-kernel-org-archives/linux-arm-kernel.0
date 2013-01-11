From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Jan 2013 18:14:07 +0000
Subject: [kvmarm] [PATCH v2 2/2] ARM: KVM: Power State Coordination
 Interface implementation
In-Reply-To: <CANM98q+mUcEs+ggxa1rgRqCgWUOnnL=BXQprxgd2548Y+dDjAw@mail.gmail.com>
References: <1357834005-23843-1-git-send-email-marc.zyngier@arm.com>
 <1357834005-23843-3-git-send-email-marc.zyngier@arm.com>
 <20130111171232.GH23505@n2100.arm.linux.org.uk> <50F04AD5.6020703@arm.com>
 <CANM98qJ2ZSwxMWFRWiunTQtoV7iFb3fn3Cf6VWvOndBcU=+Tmg@mail.gmail.com>
 <50F04F2F.80306@arm.com>
 <CANM98qLRsdFGxU6S5q2EqtCAmK8fOnbGWi8qXBktyuRkSaPAJg@mail.gmail.com>
 <20130111175714.GK23505@n2100.arm.linux.org.uk>
 <CANM98q+mUcEs+ggxa1rgRqCgWUOnnL=BXQprxgd2548Y+dDjAw@mail.gmail.com>
Message-ID: <20130111181407.GM23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 01:07:31PM -0500, Christoffer Dall wrote:
> The _very_ good reason here, is that we have two success cases: return
> to guest and return to user space. As I said, we can save this state
> in another bit somewhere and change all the KVM/ARM code to do so, but
> the KVM guys back then would like to use the same convention as other
> KVM archs.

Can you please credit me for not objecting to returning 0/1 to have
different success meanings.  What I'm merely objecting to is that
"return -1" statement in the code (notice the negative sign.)
