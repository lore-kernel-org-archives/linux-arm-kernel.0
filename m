From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 23 Oct 2013 13:39:57 +0100
Subject: [RFC PATCH] arm64: Add arch support for PCI
In-Reply-To: <1382529163-31968-1-git-send-email-tinamdar@apm.com>
References: <1382529163-31968-1-git-send-email-tinamdar@apm.com>
Message-ID: <1382531997.14960.8.camel@mbp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tanmay,

On Wed, 2013-10-23 at 12:52 +0100, Tanmay Inamdar wrote:
> This patch adds the PCI arch support in arm64 required by PCI
> midlayer. The PCI support is based on support in 32bit arm arch.

We had a discussion yesterday at the ARM mini-summit in Edinburgh about
PCI(e) support on ARMv8. Rather than creating yet another
implementation, there is a lot of code in there which is not arch
specific and should rather be generalised. There are still some debates
around whether to make the powerpc one generic (and it seems to have
some advantages in terms of DT handling) or making parts of the AArch32
implementation generic. ARM started looking into this but we don't yet
have code to share.

Catalin
