From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 7 Mar 2014 12:18:58 +0100
Subject: [linux-sunxi] Re: [PATCH v3 1/5] i2c: mv64xxx: Add reset
 deassert call
In-Reply-To: <CAGb2v66xViOx+DdnuDwad0HsCx2YiYfxqBDAEwYdLHrSydOj0w@mail.gmail.com>
References: <1393950521-4173-1-git-send-email-maxime.ripard@free-electrons.com>
 <1393950521-4173-2-git-send-email-maxime.ripard@free-electrons.com>
 <20140307095222.GG21483@n2100.arm.linux.org.uk>
 <20140307100751.GN607@lukather>
 <20140307103433.GH21483@n2100.arm.linux.org.uk>
 <CAGb2v66xViOx+DdnuDwad0HsCx2YiYfxqBDAEwYdLHrSydOj0w@mail.gmail.com>
Message-ID: <20140307111858.GB12274@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Since RESET_CONTROLLER is not required for those platforms, it really
> > should be optional - and I think the real fix is for the reset controller
> > support to provide stub functions.
> 
> Philipp Zabel suggested that adding a _optional variant that provides stubs
> and doesn't depend on RESET_CONTROLLER is probably better. This keeps the
> compile time checks for drivers requiring it.
> 
> See: https://lkml.org/lkml/2014/1/10/220
> 
> I ended up dropping my patch though.

Thanks for the pointer. Well, looks like I need to revert the offending
i2c patches then until this issue is fixed? We can't have
RESET_CONTROLLER (circular dependency) and we can't skip it (build
failures).

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140307/7a5dc2eb/attachment.sig>
