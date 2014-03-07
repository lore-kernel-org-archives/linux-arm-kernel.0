From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 7 Mar 2014 14:44:12 +0100
Subject: [linux-sunxi] Re: [PATCH v3 1/5] i2c: mv64xxx: Add reset
 deassert call
In-Reply-To: <20140307111858.GB12274@katana>
References: <1393950521-4173-1-git-send-email-maxime.ripard@free-electrons.com>
 <1393950521-4173-2-git-send-email-maxime.ripard@free-electrons.com>
 <20140307095222.GG21483@n2100.arm.linux.org.uk>
 <20140307100751.GN607@lukather>
 <20140307103433.GH21483@n2100.arm.linux.org.uk>
 <CAGb2v66xViOx+DdnuDwad0HsCx2YiYfxqBDAEwYdLHrSydOj0w@mail.gmail.com>
 <20140307111858.GB12274@katana>
Message-ID: <20140307134412.GR607@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 07, 2014 at 12:18:58PM +0100, Wolfram Sang wrote:
> 
> > > Since RESET_CONTROLLER is not required for those platforms, it really
> > > should be optional - and I think the real fix is for the reset controller
> > > support to provide stub functions.
> > 
> > Philipp Zabel suggested that adding a _optional variant that provides stubs
> > and doesn't depend on RESET_CONTROLLER is probably better. This keeps the
> > compile time checks for drivers requiring it.
> > 
> > See: https://lkml.org/lkml/2014/1/10/220
> > 
> > I ended up dropping my patch though.
> 
> Thanks for the pointer. Well, looks like I need to revert the offending
> i2c patches then until this issue is fixed? We can't have
> RESET_CONTROLLER (circular dependency) and we can't skip it (build
> failures).
> 

I just sent a fix in reply to your mail that should fix the issue
without having to revert the patches.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140307/6635e2ba/attachment.sig>
