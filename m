From: marvin24@gmx.de (Marc Dietrich)
Date: Thu, 11 Sep 2014 16:52:22 +0200
Subject: [RFC 4/4] ARM: shmobile: r8a7790: adapt DTS for I2C slave support
In-Reply-To: <20140911144003.GD5149@katana>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
 <20140911141257.GC5149@katana> <20140911144003.GD5149@katana>
Message-ID: <1591383.Xdy91rktuP@fb07-iapwap2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 11. September 2014, 16:40:04 schrieb Wolfram Sang:
> > b) could be seen as a configuration thing since the functionality
> > backend could be changed at runtime even.
> 
> Come to think of it, not only the functionality, also the address can be
> changed at runtime. This makes me think it should really not be in DT
> after all.

even worse, there can be multiple masters and slaves changing their role on 
the fly AFAIK. So the best dt can do is to provide an initial configuration, 
so all drivers know where they are and where to start. Everything else can be 
changed during runtime.

> People will probably find out that it is possible to put it in DT, but
> it should not be encouraged and they should do it on their own risk.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140911/c2e1a67a/attachment.sig>
