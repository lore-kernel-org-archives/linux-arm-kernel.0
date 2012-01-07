From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Sat, 7 Jan 2012 12:40:16 +0100
Subject: [PATCH] irqdomain: Initialize number of IRQs for simple domains
In-Reply-To: <20120106213422.GF7457@ponder.secretlab.ca>
References: <1325860112-22051-1-git-send-email-thierry.reding@avionic-design.de>
 <CACxGe6sXmC2A0ihsK=rmQ8jQ61xcc7re=LgzPPJm8wHvvkFb4Q@mail.gmail.com>
 <20120106162016.GB5593@avionic-0098.mockup.avionic-design.de>
 <20120106213422.GF7457@ponder.secretlab.ca>
Message-ID: <20120107114016.GA3655@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grant Likely wrote:
> No.  ERR_PTR is a horrible pattern because you cannot tell by looking
> at a prototype that returns a pointer whether or not the correct
> failure test is "if (!ptr)" or "if (IS_ERR(ptr))".  Unless it is
> absolutely critical for an error code to be returned (which isn't the
> case here) I will not accept new code that uses ERR_PTR().
> 
> In this case, if irq_domain_add_simple() fails, then something is very
> wrong.  I'd much rather the routine complain loudly regardless of the
> error condition.

Okay, I'll keep the WARN_ON(1) and simply return NULL.

> Actually, looking again at irq_domain_generate_simple() it should
> probably succeed even if it cannot find a matching node since an
> irq_domain does more than just device tree translation.  Although,
> irq_domain_generate_simple() is a stop-gap solution that will
> eventually be removed.

So I'll just handle errors in irq_domain_generate_simple() the same way as in
irq_domain_add_simple() and will return NULL if no matching node is found.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120107/7b937ced/attachment.sig>
