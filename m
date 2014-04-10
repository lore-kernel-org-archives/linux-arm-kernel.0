From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 10 Apr 2014 10:10:31 +0200
Subject: [PATCH 00/15] ARM: sunxi: add A31 PL pins support
In-Reply-To: <CAGb2v67+YNhw2MXSu9DTKSUfXH=v+uD7KEaxyiPezyf9CYtmPw@mail.gmail.com>
References: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
 <CAGb2v66XCN2ar1wj+a1+ZwdcdJ3gzJ+nDiO9bu52OwK+mBB_Hg@mail.gmail.com>
 <20140409151747.GH28585@lukather>
 <CAGb2v67+YNhw2MXSu9DTKSUfXH=v+uD7KEaxyiPezyf9CYtmPw@mail.gmail.com>
Message-ID: <20140410081031.GM28585@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 12:27:32AM +0800, Chen-Yu Tsai wrote:
> >> > Let me know if these changes are too intrusive.
> >>
> >> I wonder if we should do a separate driver for the new PIO controller.
> >> Clearly it's a separate IP block, with it's own clock and reset controls.
> >
> > It's been merged together in the A23, hence why we did it like that.
> 
> I'm not sure I understand. The clock gate and reset control are still separate,
> are they not?

On the A31 the "regular" port controler handles PA to PH banks, while
the R_PIO handles the PL and PM banks.

On the A23, the regular port controler handles PA to PL banks, and the
R_PIO and PM bank doesn't exist.

So we're not quite in the same situation. The A31 is troublesome,
while the A23 (except for the external interrupts), is pretty much
what we've seen so far with the A10/A20/...

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140410/60765c7c/attachment.sig>
