From: broonie@kernel.org (Mark Brown)
Date: Wed, 22 Jan 2014 18:11:06 +0000
Subject: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states bindings
In-Reply-To: <20140122163322.GF24288@e102568-lin.cambridge.arm.com>
References: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1390240079-6495-3-git-send-email-lorenzo.pieralisi@arm.com>
 <CAKfTPtAbYXuis1bfyDLiHRaYwosre3RAG+iNQSz-y+cWfc3uQA@mail.gmail.com>
 <20140121133148.GB28801@e102568-lin.cambridge.arm.com>
 <20140122114232.GB20247@sirena.org.uk>
 <20140122163322.GF24288@e102568-lin.cambridge.arm.com>
Message-ID: <20140122181106.GQ17314@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 04:33:22PM +0000, Lorenzo Pieralisi wrote:
> On Wed, Jan 22, 2014 at 11:42:32AM +0000, Mark Brown wrote:

> > Would it not be sensible to define a PSCI binding that extends this and
> > other bindings - ISTR some other properties getting scattered into
> > bindings for it?

> You mean adding the properties in the PSCI bindings instead of defining
> them here ? Let me think about this, I really reckon these are C-state

Yes.

> specific properties that belong in here (but actually I have to add
> a statement related to PSCI - ie bindings require a PSCI node to be
> present and valid), I will look into this.

It depends how you think about it - something like PSCI is going to to
define properties used in a bunch of different parts of the low level
code, it seems reasonable for things like this to say that the user
should refer to the binding for the firmware to find out what options
that firmware requires and can support rather than having to refer to
each individual place and have those places enumerate the options for
each firmware.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140122/6f4b6644/attachment.sig>
