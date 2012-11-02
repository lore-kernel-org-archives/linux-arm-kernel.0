From: tony@atomide.com (Tony Lindgren)
Date: Fri, 2 Nov 2012 09:37:53 -0700
Subject: [PATCH v3 5/9] document: devicetree: bind pinconf with pin-single
In-Reply-To: <5092B9A0.9000204@wwwdotorg.org>
References: <1351724661-29050-1-git-send-email-haojian.zhuang@gmail.com>
 <1351724661-29050-6-git-send-email-haojian.zhuang@gmail.com>
 <5092B9A0.9000204@wwwdotorg.org>
Message-ID: <20121102163752.GV15766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren <swarren@wwwdotorg.org> [121101 11:06]:
> On 10/31/2012 05:04 PM, Haojian Zhuang wrote:
> > Add comments with pinconf & gpio range in the document of
> > pinctrl-single.
> 
> I'd tend to suggest separating the series to add GPIO range support and
> pinconf support, especially since didn't Tony suggest a separate driver
> for pinconf? Perhaps that was just for non-generic properties.

Well I was just thinking setting them up as separate driver
instances for the register ranges supporting pinconf and
not supporting pinconf. This combined with some pinconf
property parsed during pinctrl-single.c probe time allows
saving lots of unnecessary parsing of properties for
register ranges that don't support pinconf. At least for
omaps we have few hundred registers that don't support
pinconf, and then some separate random register that do.

Regards,

TOny 
