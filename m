From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 22 Aug 2017 16:41:11 +0100
Subject: [PATCH 09/27] arm64/sve: Signal frame and context structure
 definition
In-Reply-To: <87shgj4pc7.fsf@linaro.org>
References: <1502280338-23002-1-git-send-email-Dave.Martin@arm.com>
 <1502280338-23002-10-git-send-email-Dave.Martin@arm.com>
 <87y3qb52ez.fsf@linaro.org>
 <20170822111705.GT6321@e103592.cambridge.arm.com>
 <87tw0z4sk2.fsf@linaro.org>
 <20170822142135.GU6321@e103592.cambridge.arm.com>
 <87shgj4pc7.fsf@linaro.org>
Message-ID: <20170822154111.GW6321@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 22, 2017 at 04:03:20PM +0100, Alex Benn?e wrote:
> 
> Dave Martin <Dave.Martin@arm.com> writes:
> 
> > On Tue, Aug 22, 2017 at 02:53:49PM +0100, Alex Benn?e wrote:

[...]

> >> +
> >> +#define SVE_VQ_BITS             128      /* 128 bits in one quadword */
> >> +#define SVE_VQ_BYTES            (SVE_VQ_BITS / 8)
> >> +
> >
> > I was trying to keep extraneous #defines to a minimum, since this is a
> > uapi header, and people may depend on anything defined here.
> >
> > I think SVE_VQ_BYTES is reasonable to have, and this allows us to
> > rewrite a few hard-coded 0x10s and 16s symbolically which is probably a
> > good idea -- I'll add this.
> >
> > SVE_VQ_BITS looks redundant to me though.  It wouldn't be used for any
> > purpose other than defining SVE_VQ_BYTES.
> 
> Yeah I was more concerned with getting rid of the magic 0x10's than
> showing exactly how many bits something is.

OK, I'll take SVE_VQ_BYTES and use it in the appropriate places.
There are a few 0x10s/16s in the series that can use this instead
of being open-coded.

Cheers
---Dave
