From: broonie@kernel.org (Mark Brown)
Date: Wed, 11 Dec 2013 14:30:18 +0000
Subject: [PATCH 4/6] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20131211142431.GD596@darko.cambridge.arm.com>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
 <1386767606-6391-4-git-send-email-broonie@kernel.org>
 <20131211141224.GG26730@mudshark.cambridge.arm.com>
 <20131211141503.GX11468@sirena.org.uk>
 <20131211142431.GD596@darko.cambridge.arm.com>
Message-ID: <20131211143018.GZ11468@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 02:24:32PM +0000, Catalin Marinas wrote:
> On Wed, Dec 11, 2013 at 02:15:03PM +0000, Mark Brown wrote:

> > He said he hadn't had time to work on the actual implementation which is
> > why I picked this up - as far as I'm aware we only have the (already
> > merged) binding for this.

> Lorenzo (on holiday now) pushed the DT topology bindings but there are
> no patches yet for reading them. I would much prefer to only describe
> the topology via DT rather than MPIDR (because hardware people sometimes
> have strange ideas).

Right, that was my understanding too.  

For clarity the current code only uses DT information, the MPIDR values
it uses are those in the CPU nodes in the DT which are used by the SMP
code and are not read from the hardware.  We can drop that bit of code
easily enough but it seemed useful for getting the scaffolding in place
separately to the binding parsing and for general robustness, perhaps
adding a patch at the end of the series to drop the code handling MPIDR
would deal with the application issues?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131211/c84aaf90/attachment.sig>
