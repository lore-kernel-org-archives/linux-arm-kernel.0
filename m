From: broonie@kernel.org (Mark Brown)
Date: Thu, 18 Sep 2014 10:21:47 -0700
Subject: [PATCH] arm64: insn: Add return statements after BUG_ON()
In-Reply-To: <20140918170205.GE25330@e104818-lin.cambridge.arm.com>
References: <1410885753-25025-1-git-send-email-broonie@kernel.org>
 <20140918170205.GE25330@e104818-lin.cambridge.arm.com>
Message-ID: <20140918172147.GX7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 18, 2014 at 06:02:06PM +0100, Catalin Marinas wrote:
> On Tue, Sep 16, 2014 at 05:42:33PM +0100, Mark Brown wrote:

> >  	default:
> >  		BUG_ON(1);
> > +		return 0;
> >  	}

> Wouldn't there be less lines if we initialise insn to 0 in these
> functions?

In general that's bad practice since it means that you loose the benefit
of flow analysis on that variable throughout the function - it will shut
the warning up but if someone introduces a bug later on the compiler
won't be able to tell them about it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140918/b75f0cc9/attachment.sig>
