From: dyoung@redhat.com (Dave Young)
Date: Mon, 10 Nov 2014 17:24:07 +0800
Subject: [PATCH 00/10] arm64 kexec kernel patches V5
In-Reply-To: <CAFdej03v3M=jtTEVv7rxe8z_h_apUKNzq7GcUSLwZtQ5DSnxkg@mail.gmail.com>
References: <cover.1414099246.git.geoff@infradead.org>
 <CAFdej01qZMr3CgBv6jOuXHod2F8zHg89yDA8FA4m65bFEn+vYw@mail.gmail.com>
 <20141106152830.GF23706@leverpostej>
 <CAFdej01wki9btKiDj7TW8_frtZFLVMjsyS5LsZWqO7E+dC+D+w@mail.gmail.com>
 <20141110071752.GC6960@darkstar.nay.redhat.com>
 <CAFdej03v3M=jtTEVv7rxe8z_h_apUKNzq7GcUSLwZtQ5DSnxkg@mail.gmail.com>
Message-ID: <20141110092407.GD6960@darkstar.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[snip]
> >> Yes. My earlyconsole setting was wrong that is why I did not see
> >> anything in console for the kexec rebooting.
> >>
> >> With correct earlycon setting I can see
> >
> > Arun, could you share how did you get the working earlycon? We might have
> > same problem..
> 
> I invoked kexec like this
> 
>  root at genericarmv8:~# ./usr/local/sbin/kexec --lite -l vmlinux --command-line=
> "root=/dev/nfs rw
> nfsroot=10.162.103.145:/nfs_root/linaro-image-lamp-genericarmv8,nfsvers=3
> ip=:::::eth0:dhcp panic=1 console=ttyS0,115200
> earlycon=uart8250,mmio32,0x1c020000"
> 
> 
> Earlier my command line parameters for earlycon was wrong hence I was
> not getting
> earlyconsole.
> 
> Also have a look at
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/300584.html
> 
> If your board has an L3 cache; you may have to apply the modification in the
> above link.

Arun, thanks a lot. Will try when I get a machine this week.

Dave
