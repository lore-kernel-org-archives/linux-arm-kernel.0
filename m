From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Feb 2014 14:56:44 +0000
Subject: [PATCH] arm64: smp: Add a memory barrier before we start
 secondary cores
In-Reply-To: <20140212134332.GK29702@arm.com>
References: <1392205594-29186-1-git-send-email-broonie@kernel.org>
 <20140212122727.GB29132@mudshark.cambridge.arm.com>
 <20140212124717.GL28112@sirena.org.uk>
 <20140212134332.GK29702@arm.com>
Message-ID: <20140212145644.GP28112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 01:43:32PM +0000, Catalin Marinas wrote:

> I think we can drop this until Vincent clarifies the synchronisation
> requirements (still wondering whether spinlocks are needed).

Even if they're not actually required for the topology code the fact
that we're having to think about what is needed suggests that the code
is going to end up being clearer and hence more maintainable going
forwards if we add it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140212/ce0335a1/attachment.sig>
