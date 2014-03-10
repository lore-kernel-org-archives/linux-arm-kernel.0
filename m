From: broonie@kernel.org (Mark Brown)
Date: Mon, 10 Mar 2014 18:01:31 +0000
Subject: [RFC PATCH 3/6] PM / Voltagedomain: introduce voltage domain
 driver support
In-Reply-To: <531DF931.1060108@ti.com>
References: <1392755543-28335-1-git-send-email-nm@ti.com>
 <1392755543-28335-4-git-send-email-nm@ti.com>
 <20140224015826.GU25940@sirena.org.uk> <530B594F.2030500@ti.com>
 <20140303035426.GC2411@sirena.org.uk> <531DF250.5060100@ti.com>
 <20140310172221.GT28112@sirena.org.uk> <531DF931.1060108@ti.com>
Message-ID: <20140310180131.GZ28112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 10, 2014 at 12:41:05PM -0500, Nishanth Menon wrote:

> The only other options are:
> a) Abstract it at a higher level at "user drivers", since they are
> aware of the sequencing needs - but this partially defeats the
> purpose, unless ofcourse, we do a tricky implementation such as:
> clk a, b, c -> prenotifiers in a, postnotifiers in c (which as you
> mentioned is a little trickier to get right).
> b) introduce a higher level generic dvfs function[1] which does not
> seem very attractive either.

> Any other suggestions other than limiting the usage(and documenting it
> so) and hoping for a future evolution to take this into consideration?

Something might be doable with telling the clock API about maintianing
ratios between clocks?  I do think we should have an idea where we'd go
with such requirements, even if we don't currently handle it, so that we
can hopefully avoid another round of refactoring everything but it
doesn't seem 100% essential, just very nice to have.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140310/b5dd9a96/attachment.sig>
