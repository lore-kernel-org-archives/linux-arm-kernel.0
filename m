From: broonie@kernel.org (Mark Brown)
Date: Thu, 19 Feb 2015 20:55:57 +0900
Subject: [PATCH 2/2] regmap: Add range check in _regmap_raw_write()
In-Reply-To: <54E5C4FE.5080604@linaro.org>
References: <1424335193-7431-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1424335255-7517-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20150219103156.GD3198@finisterre.sirena.org.uk>
 <54E5C4FE.5080604@linaro.org>
Message-ID: <20150219115557.GA1581@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 19, 2015 at 11:11:58AM +0000, Srinivas Kandagatla wrote:
> On 19/02/15 10:31, Mark Brown wrote:

> >Your changelog doesn't correspond to what the code is actually doing
> >here...  what you're actually doing here is replacing an open coding of
> >regmap_writeable() with calls to the function.

> Only reason for me to send this patch was that fact that _regmap_raw_write()
> also suffers from same issue as _regmap_raw_read(), which is "access beyond
> max_register".

> Should I drop this patch?
> Or
> Adding similar check of max_register before the writing makes sense?

No, please go and reread your patch - neither your description above nor
the changelog match up with what it's actually doing.  It looks like a
perfectly sensible patch, it just doesn't do what you're saying it does.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150219/4a1a2b94/attachment.sig>
