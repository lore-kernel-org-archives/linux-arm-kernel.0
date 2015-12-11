From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Dec 2015 16:31:44 +0000
Subject: [PATCH v12 04/16] arm64: kvm: allows kvm cpu hotplug
In-Reply-To: <1449772308.24127.59.camel@infradead.org>
References: <cover.1448403503.git.geoff@infradead.org>
 <23ca498d5e28017549c6076812d60b18e86fa20e.1448403503.git.geoff@infradead.org>
 <CAJ5Y-eYHqQCf=ZQzXb=D_P7VscM=vNc3YpYLJs+UtZLFswiaeQ@mail.gmail.com>
 <56604A6E.60102@arm.com> <1449772308.24127.59.camel@infradead.org>
Message-ID: <20151211163144.GK18828@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 10:31:48AM -0800, Geoff Levand wrote:
> On Thu, 2015-12-03 at 13:58 +0000, Marc Zyngier wrote:
> > Indeed, this is completely broken (I just reproduced the issue on a
> > model).
> 
> There are users out there that want kexec/kdump support.  I think we
> should remove this patch from the series, replace it with a temporary
> Kconfig conditional that allows only one of KVM or kexec to be enabled,
> and merge kexec and kdump support in for 4.5.  This will satisfy users
> who need kexec but not KVM, like kexec based bootloaders.  Once this
> KVM hot plug patch is fixed we then merge it, either for 4.5 or 4.6,
> depending on the timing.
> 
> I'll prepare and post a v13 series that does the above.

I'm not really keen on merging this based on a "temporary" Kconfig change
with a promise to have it resolved in the future. Given how long this
series has been floating around already, I'm not filled with confidence
at the prospect of waiting for a fixup patch after it's been merged.

Please address the outstanding review comments before reposting.

Will
