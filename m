From: p.fedin@samsung.com (Pavel Fedin)
Date: Wed, 07 Oct 2015 18:46:04 +0300
Subject: [PATCH v3 12/16] KVM: arm64: handle pending bit for LPIs in ITS
 emulation
In-Reply-To: <56153BD2.1050904@arm.com>
References: <1444229726-31559-1-git-send-email-andre.przywara@arm.com>
 <1444229726-31559-13-git-send-email-andre.przywara@arm.com>
 <026901d10112$4dea39d0$e9bead70$@samsung.com> <56153BD2.1050904@arm.com>
Message-ID: <028c01d10117$46bd9440$d438bcc0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> Sure. And you then have to parse and validate all the tables each and
> every time you're going to inject an interrupt (because the guest can
> change the table content behind your back). You are quickly going to
> notice that your performance is abysmal.

 I don't see any real problems, at least with LPI tables. If the guest changes something, it will be
immediately available to us. I don't see any need to seriously validate something, at least here.
Pending bit is just pending bit, and configuration is just priority value plus enable bit.
 But, well, if we think a bit better, in case of pending bit modification, the operations on both
guest and host side have to be atomic, otherwise we can clobber our table if, for example, both host
and guest modify adjacent bits. And there's no way to interlock with the guest. So, OK, i accept
your point.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
