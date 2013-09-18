From: wbx@openadk.org (Waldemar Brodkorb)
Date: Wed, 18 Sep 2013 17:07:13 +0200
Subject: problem booting linux with qemu-system-arm -M spitz
In-Reply-To: <CAAQYJAv+rUiv5=qnL74WR9gFzv84SCwPcTNRcJcMcR8+pf75BQ@mail.gmail.com>
References: <20130918102701.GJ14246@waldemar-brodkorb.de>
 <CAAQYJAv+rUiv5=qnL74WR9gFzv84SCwPcTNRcJcMcR8+pf75BQ@mail.gmail.com>
Message-ID: <20130918150713.GK14246@waldemar-brodkorb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
Andrea Adami wrote,

> On Wed, Sep 18, 2013 at 12:27 PM, Waldemar Brodkorb <wbx@openadk.org> wrote:
> > Hi Kernel hackers,
> >
> > I am trying to run Linux on Qemu/arm emulator with machine type
> > spitz. In the past this worked fine.
> > Now with Linux version 3.9.11 it does not boot anymore.
> > (blank screen, no kernel messages)
> >
> > I used git bisect to find the commit, which breaks the boot:
> > commit 4e8ee7de227e3ab9a72040b448ad728c5428a042
> > Author: Will Deacon <will.deacon@arm.com>
> > Date:   Wed Nov 23 12:26:25 2011 +0000
> >
> > I am using Qemu 1.6.0 on a Debian/x86_64 host.
> >
> > Any help would be appreciated.
> >
> > Thanks in advance
> >  Waldemar
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> On real hardware I see the same breakage after 3.2.
> Marko diagnosed it and there is a pending patch:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/198444.html
> 
> There is indeed some MMU-related issue.
> Probably the function could be called elsewhere during machine init
> but I'm not so high in the food chain to dare to touch arm boot code
> ;)
> 
> Regards

Great! Thank you very much, this works fine.

best regards
 Waldemar
