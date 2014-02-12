From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Feb 2014 12:47:17 +0000
Subject: [PATCH] arm64: smp: Add a memory barrier before we start
 secondary cores
In-Reply-To: <20140212122727.GB29132@mudshark.cambridge.arm.com>
References: <1392205594-29186-1-git-send-email-broonie@kernel.org>
 <20140212122727.GB29132@mudshark.cambridge.arm.com>
Message-ID: <20140212124717.GL28112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 12:27:28PM +0000, Will Deacon wrote:
> On Wed, Feb 12, 2014 at 11:46:34AM +0000, Mark Brown wrote:

> > Ensure that memory writes will be visible to the newly started core by
> > inserting a write barrier prior to starting. This adds robustness against
> > possible incomplete synchronisation of state.

> This is very vague. I still don't understand what this is being used for.

Me either to be honest, I wasn't entirely sure why Catalin had suggested
it.

> Without a concrete example of precisely why this is required, I'm not at all
> happy taking patches adding random memory barriers.

That's fine by me, I've no attachment to this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140212/12b5ba9a/attachment.sig>
