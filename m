From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 30 May 2013 07:44:14 -0700
Subject: [GIT PULL] KVM/ARM Fixes for 3.10
In-Reply-To: <CAEDV+gJrWqoMdqibetTo++FzW6NXE5QkF0TCTHoFJmadmpeKiQ@mail.gmail.com>
References: <CAMJs5B8qTMpaaq0y=xGUrTzUd_-LvmARdGABV8PdpqmWUkPoqw@mail.gmail.com>
 <51A6E78F.3070902@redhat.com>
 <CAEDV+gJrWqoMdqibetTo++FzW6NXE5QkF0TCTHoFJmadmpeKiQ@mail.gmail.com>
Message-ID: <20130530144414.GA56688@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 30, 2013 at 07:20:23AM -0700, Christoffer Dall wrote:
> On Wed, May 29, 2013 at 10:45 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
> > Il 30/05/2013 03:39, Christoffer Dall ha scritto:
> > > The following changes since commit
> > e47a5f5fb715b90b40747e9e235de557c6abd56c:
> > >
> > >   KVM: x86 emulator: convert XADD to fastop (2013-05-21 15:43:24 +0300)
> >
> > Chris,
> >
> > this is based on the "next" branch, which will not be merged until the
> > 3.11 merge window.  Please base your 3.10 fixes on the "master" branch
> > of kvm.git.
> >
> > Thanks!
> >
> > Paolo
> >
> >
Duh, sorry about that. Here's the new pull request (I just rebased the same
branch):


The following changes since commit 514e250f67d2b2a8ab08dc9c3650af19a411c926:

  Merge tag 'gpio-fixes-v3.10-1' of git://
git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio (2013-05-23
18:24:10 -0700)

are available in the git repository at:


  git://github.com/columbia/linux-kvm-arm.git kvm-arm-fixes-3.10

for you to fetch changes up to edd89c08e6570bb88a3f275bf0d7cffcea2f1e87:

  ARM: KVM: be more thorough when invalidating TLBs (2013-05-30 07:17:07
-0700)

----------------------------------------------------------------
Andre Przywara (1):
      ARM: KVM: prevent NULL pointer dereferences with KVM VCPU ioctl

Marc Zyngier (1):
      ARM: KVM: be more thorough when invalidating TLBs

 arch/arm/kvm/arm.c |   15 +++++++++++++--
 arch/arm/kvm/mmu.c |   41 ++++++++++++++++++++++++++---------------
 2 files changed, 39 insertions(+), 17 deletions(-)
