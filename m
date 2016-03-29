From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Mar 2016 21:04:20 +0100
Subject: Bad mode in undefined instruction handler detected
In-Reply-To: <CAF_dkJBR+n-ijE2YBmt3KR=B3VOkh4mu-d5YiXNDDCVihkgH6Q@mail.gmail.com>
References: <CAF_dkJBa3Y1EZGduZyjWqV3p5s7zf+Y4ppdeKW8anhd5nkjOPg@mail.gmail.com>
 <20160329165940.GA19428@n2100.arm.linux.org.uk>
 <CAF_dkJA=4iqD=siV5RM7KTDfEQGtKc3G17E+C+K+-_hmneK4aA@mail.gmail.com>
 <20160329182922.GC19428@n2100.arm.linux.org.uk>
 <CAF_dkJBR+n-ijE2YBmt3KR=B3VOkh4mu-d5YiXNDDCVihkgH6Q@mail.gmail.com>
Message-ID: <20160329200420.GD19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2016 at 03:18:08PM -0400, Patrick Doyle wrote:
> On Tue, Mar 29, 2016 at 2:29 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > THUMB2_KERNEL is an option, which I believe you already have disabled.
> > So, the offending option is probably ARM_UNWIND.  You are provided with
> > the ARM_UNWIND option, and you need to say no to that.  Don't try to
> > build a kenrel with frame pointers and unwinding together - it'll
> > probably fail, or if you succeed in building it, it probably won't
> > work correctly since that's a combination we don't support.
> >
> Right, I can confirm that building with both produces a kernel that
> doesn't boot (for me anyway).  Unfortunately, enabling FRAME_POINTER
> instead of ARM_UNWIND produced a kernel which, when it crashed only
> told me:
> 
> Unable to handle kernel paging request at virtual address e5912144
> pgd = c0004000
> [e5912144] *pgd=00000000
> Internal error: Oops: 5 [#1] ARM
> 
> Is there something else I need to enable to get a more verbose dump?

Sounds like you're getting memory corruption, and this time it's
(possibly) overwriting bits of the kernel responsible for dumping
this data.

If it only happens when using the camera, it sounds to me (at least)
as though the camera driver is buggy, and that's outside of my
expertise.  That's guess-work though.

I'm afraid that I don't think I can help in this case, sorry.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
