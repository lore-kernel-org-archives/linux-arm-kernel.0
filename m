From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 24 Jun 2015 08:34:28 +1000
Subject: [RFC 3/4] arm64: Do not call enable PCI resources when specify
 PCI_PROBE_ONLY
In-Reply-To: <CAErSpo6SngcV6_Ew0DOjW+xTw8y6j3UmwdPw1x-tk_AB=mapaQ@mail.gmail.com>
References: <1411937610-22125-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1411937610-22125-4-git-send-email-suravee.suthikulpanit@amd.com>
 <CAErSpo6SngcV6_Ew0DOjW+xTw8y6j3UmwdPw1x-tk_AB=mapaQ@mail.gmail.com>
Message-ID: <1435098868.3996.11.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-09-29 at 12:17 -0600, Bjorn Helgaas wrote:
> This seems like more than necessary, but I don't know all the history.
> In particular, I don't know why PCI_PROBE_ONLY should make a
> difference to things like claiming resources.

It shouldn't ... we created that option on ppc originally to avoid
allocation/reallocation of resources. If they are bad, leave them bad,
but it was never a question of disabling all these other things.

(Ok, the MRSS/MPS is debatable, but why not plumb the parent pointers
and why not claim ? That doesn't make sense to me).

Cheers,
Ben.
