From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 20 Mar 2015 14:42:02 +0000
Subject: [patch 2/7] dt: dtb version: document chosen/dtb-info node binding
In-Reply-To: <550B3549.1030808@gmail.com>
References: <550A42AC.8060104@gmail.com> <550A4382.4030209@gmail.com>
 <CAL_Jsq+sPkZtreQ0sp8KXpkUVpFy=Yh9dr249u8uyoa8yksjmg@mail.gmail.com>
 <20150319184139.GG8656@n2100.arm.linux.org.uk>
 <550B1D16.7000108@gmail.com>
 <20150319193225.GH8656@n2100.arm.linux.org.uk>
 <550B3549.1030808@gmail.com>
Message-ID: <20150320144202.GH14766@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > You must be *absolutely* *sure* that you want to export this information,
> > and that you are absolutely happy with the consequences which would occur
> > should userspace then start using this information in a way which you did
> > not intend, which could very well block you from ever being able to change
> > the version number from a prescribed "this version number makes userspace
> > work" value.
> 
> I understand the concern you are expressing.  And I agree it is an issue to
> be concerned about and not dismissed.  But I also think that the concern is
> mis-characterizing the "DTB version".  To pick on the example in patch 0,
> an analogous Linux version is "#5" (not "4.0.0"):
> 
>    Linux version 4.0.0-rc4-dirty (frank at buildhost) (gcc version 4.6.x-google 20120106 (prerelease) (GCC) ) #5 SMP PREEMPT Wed Mar 18 20:04:48 PDT 2015
> 
> and the proposed DTB version is "#4":
> 
>    DTB version 4.0.0-rc4-dirty (frank at buildhost) (DTC 1.4.0-dirty) #4 Wed Mar 18 20:04:11 PDT 2015
> 
> I don't think the concern holds for "#5" and "#4".
> 
> I will concede that there is something unique in the proposed DTB version -
> the source code system commit version number (in this example "4.0.0-rc4-dirty"
> from git).

The problem that Russell is describing is that regardless of the origin
and intended purpose of the value, some consumer of the value will
decide that some arbitrary value means something special to them (even
if it does not), and when this changes thigns will break.

So in that respect, it doesn't matter where the value came from or what
you intend it to mean; it will almost certainly be abused. We try to
avoid introducing fragile interfaces like these.

Mark.
