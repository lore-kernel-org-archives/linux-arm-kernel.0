From: broonie@kernel.org (Mark Brown)
Date: Sat, 22 Feb 2014 11:06:02 +0900
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <20140221150140.GB495@e102568-lin.cambridge.arm.com>
References: <1392037324-5069-1-git-send-email-broonie@kernel.org>
 <20140221150140.GB495@e102568-lin.cambridge.arm.com>
Message-ID: <20140222020602.GG25940@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 21, 2014 at 03:01:40PM +0000, Lorenzo Pieralisi wrote:

> If the DT does not contain a proper topology the scheduler seem to go for a
> toss. I tried to track it down and it seems it expects topology cpumasks to be
> initialized regardless (eg to possible mask), they cannot be left empty.

Could you be more specific please?  I didn't notice anything particular
in my testing but then the fact that it's a model does obscure a lot of
things.

> On top of that, the pr_info message is quite annoying and should be
> probably downgraded or removed altogether.

This was deliberate - since we are not willing to use the MPIDR
information to discover the topology we need to get the information into
the DT bindings in order to discover it.  Even in a SMP system there is
a difference in how closely attached the cores are so it seems like we
should be expecting a description of the topology.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140222/c5be7caa/attachment.sig>
