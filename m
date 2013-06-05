From: gleb@redhat.com (Gleb Natapov)
Date: Wed, 5 Jun 2013 15:57:40 +0300
Subject: Planning the merge of KVM/arm64
In-Reply-To: <20130605093145.GB8758@arm.com>
References: <51ADDDAE.4040705@arm.com>
 <CAMJs5B_PB1pNVCO_EK7aTghN23L+d0RovAFi7inrVsJb5STWOA@mail.gmail.com>
 <51AE00D7.9030607@arm.com> <51AE082C.6050907@redhat.com>
 <CAMJs5B9PxHfUrugov4HJknQ24fG7MNp8obziqu9dnSztsGBksQ@mail.gmail.com>
 <51AE0D0D.3030106@redhat.com> <20130604163741.GA15299@redhat.com>
 <CAMJs5B8WqiMpqj3Mr=rPCr89k-jvY2i3BDbkPOsMb3PhCR1SWg@mail.gmail.com>
 <20130605060105.GA1187@redhat.com> <20130605093145.GB8758@arm.com>
Message-ID: <20130605125740.GA4725@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 10:31:46AM +0100, Catalin Marinas wrote:
> On Wed, Jun 05, 2013 at 07:01:05AM +0100, Gleb Natapov wrote:
> > On Tue, Jun 04, 2013 at 10:57:32PM -0700, Christoffer Dall wrote:
> > > On 4 June 2013 09:37, Gleb Natapov <gleb@redhat.com> wrote:
> > > > On Tue, Jun 04, 2013 at 05:51:41PM +0200, Paolo Bonzini wrote:
> > > >> Il 04/06/2013 17:43, Christoffer Dall ha scritto:
> > > >> > Hi Paolo,
> > > >> >
> > > >> > I don't think this is an issue. Gleb and Marcelo for example pulled
> > > >> > RMK's stable tree for my KVM/ARM updates for the 3.10 merge window and
> > > >> > that wasn't an issue.  If Linus pulls the kvm/next tree first the
> > > >> > diffstat should be similar and everything clean enough, no?
> > > >> >
> > > >> > Catalin has previously expressed his wish to upstream the kvm/arm64
> > > >> > patches directly through him given the churn in a completely new
> > > >> > architecture and he wants to make sure that everything looks right.
> > > >> >
> > > >> > It's a pretty clean implementation with quite few dependencies and
> > > >> > merging as a working series should be a priority instead of the
> > > >> > Kconfig hack, imho.
> > > >>
> > > >> Ok, let's see what Gleb says.
> > > >>
> > > > I have no objection to merge arm64 kvm trough Catalin if it mean less
> > > > churn for everyone. That's what we did with arm and mips. Arm64 kvm
> > > > has a dependency on kvm.git next though, so how Catalin make sure that
> > > > everything looks right? Will he merge kvm.git/next to arm64 tree?
> > > >
> > > Yes, that was the idea. Everything in kvm/next is considered stable, right?
> > > 
> > Right. Catalin should wait for kvm.git to be pulled by Linus next merge
> > windows before sending his pull request then.
> 
> I think it's better if I push the bulk of the arm64 KVM branch but
> without Kconfig patch enabling it. This branch would be based on
> mainline rather than kvm/next. Once your code goes in mainline, I'll
> just push the Kconfig entry (for bisection reasons, it could be after
> -rc1). This would keep the pull-request diffstat cleaner.
> 
If there will be no non trivial conflicts between your tree and kvm/next
it should be OK too.

> As we discussed some time ago, after the core arm64 KVM is merged you
> will use the same workflow as for arm (merge via the kvm tree).
> 
> Thanks.
> 
> -- 
> Catalin

--
			Gleb.
