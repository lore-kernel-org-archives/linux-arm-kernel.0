From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 16 Feb 2012 11:01:17 -0800
Subject: [PATCH] serial/sirf: fixup for changes to pin control
In-Reply-To: <1329417828-6005-1-git-send-email-linus.walleij@linaro.org>
References: <1329417828-6005-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1790EC8791@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote at Thursday, February 16, 2012 11:44 AM:
> We changed the signature of the pin multiplexing functions to
> handle any pin business, so fix up the Sirf driver to call this
> new interface and rename some variables to make the semantics
> understandable.
> 
> Cc: linux-serial at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Looks good to me for now.

I'll have to do another similar change when I implement the pinctrl_get
API changes we discussed at Linaro Connect (I should start implementing
that today), but I guess that's no big deal.

Should this patch be put into the pinctrl tree since that's where the
API changed, perhaps even squashed into the original commit to avoid
git bisect breakage, unless your branch needs to be stable? Otherwise,
this change will conflict with my future similar change if pulled for
the same kernel version.

-- 
nvpublic
