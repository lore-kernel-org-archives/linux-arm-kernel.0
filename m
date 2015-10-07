From: p.fedin@samsung.com (Pavel Fedin)
Date: Wed, 07 Oct 2015 21:09:07 +0300
Subject: [PATCH v3 00/16] KVM: arm64: GICv3 ITS emulation
In-Reply-To: <561546AF.90903@arm.com>
References: <1444229726-31559-1-git-send-email-andre.przywara@arm.com>
 <029601d1011a$026e1000$074a3000$@samsung.com> <561546AF.90903@arm.com>
Message-ID: <02c301d1012b$42cb8270$c8628750$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> LPIs do not have an active state, at the redistributor or otherwise.

 Then what do they become after they were ACK'ed and before EOI'ed?
 I tried to google up this thing, and came up with this email:
http://www.spinics.net/lists/kvm-arm/msg16032.html. It says that "SW must issue a write to EOI to
clear the active priorities register, hence the CPU interface still requires an active state for
LPIs". They give a link to some document which seems to be top-secret and never published, because
my arch reference manual does not have section 4.8.3 named "Properties of LPI".
 And another thread, http://lists.xen.org/archives/html/xen-devel/2014-09/msg01141.html, says that
virtual LPIs actually do have active state in LR.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
