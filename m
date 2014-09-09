From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Sep 2014 12:22:21 +0100
Subject: [PATCH] regulator: mc13xxx: add missing of_node_get()
In-Reply-To: <CAFRkauBhzHot9=z-Jv-rvdLaSWSfyYSULMKqcVX+tiHcXrxt_g@mail.gmail.com>
References: <1410260825-21667-1-git-send-email-guodong.xu@linaro.org>
 <CAFRkauBhzHot9=z-Jv-rvdLaSWSfyYSULMKqcVX+tiHcXrxt_g@mail.gmail.com>
Message-ID: <20140909112221.GP2601@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 07:11:46PM +0800, Axel Lin wrote:
> 2014-09-09 19:07 GMT+08:00 Guodong Xu <guodong.xu@linaro.org>:
> > mc13xxx_parse_regulators_dt() goes through dt tree to search for regulator
> > sub-nodes. For each matched node, later on it will be used and registered
> > into a regulator_dev.
> >
> > of_node_get() should be called to increase its refcount.

> I think it's done by regulator core:

> commit 63c7c9e16c8e92cc069854f2babdf82d2d38e4c7
> regulator: core: Get and put regulator of_node

Yes, that's the idea anyway.  It's possible this is buggy though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140909/bc7be692/attachment.sig>
