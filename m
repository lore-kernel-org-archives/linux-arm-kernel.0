From: broonie@kernel.org (Mark Brown)
Date: Thu, 19 Feb 2015 21:21:33 +0900
Subject: [PATCH 1/2] regmap: Add range check in _regmap_raw_read()
In-Reply-To: <54E5C347.9070105@linaro.org>
References: <1424335193-7431-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1424335239-7475-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20150219102750.GC3198@finisterre.sirena.org.uk>
 <54E5C347.9070105@linaro.org>
Message-ID: <20150219122133.GB1581@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 19, 2015 at 11:04:39AM +0000, Srinivas Kandagatla wrote:
> On 19/02/15 10:27, Mark Brown wrote:

> >readability.  A cheaper check for just max_register would be less
> >concerning but it feels like we're trying to paper over a symptom with
> >this rather than fix a problem.

> Yes, just checking max_register would solve the issue for me, I think I over
> done the patch.. I will resend with just max_register check.

I'm still not happy with that, it still seems like we're just papering
over some other problem here which we should understand before we do
anything else.  Why are we generating out of bounds accesses in the
first place?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150219/43da5572/attachment.sig>
