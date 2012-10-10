From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 10 Oct 2012 18:46:44 +0000 (UTC)
Subject: [PATCH 3.6.0- 0/6] ARM: use module_platform_driver macro
In-Reply-To: <1349893796-6947-1-git-send-email-srinivas.kandagatla@st.com>
References: <1349893796-6947-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <alpine.DEB.2.00.1210101837440.5736@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Wed, 10 Oct 2012, Srinivas KANDAGATLA wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> 
> Running below Coccinelle lookup pattern like below on the 
> latest kernel showed about 52 hits. This patch series is a subset 
> of those 52 patches, so that it will be easy for maintainers to review.

so the idea looks okay to me, but several of the patches aren't addressed 
to the right people.  You can use the MAINTAINERS file to figure out the 
right place to send them.

The PXA patches need to go to the appropriate PXA people, who are 
probably:

M:      Eric Miao <eric.y.miao@gmail.com>
M:      Russell King <linux@arm.linux.org.uk>
M:      Haojian Zhuang <haojian.zhuang@gmail.com>
L:      linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)

The OMAP RNG patch needs to go to 

M:      Deepak Saxena <dsaxena@plexity.net>
M:      Matt Mackall <mpm@selenic.com>
M:      Herbert Xu <herbert@gondor.apana.org.au>

As far as the remaining three OMAP patches go, they look okay to me but 
Tony Lindgren is the maintainer of these files and so he's the right 
person to merge them.

> Hopefully these patches will get rid of some code duplication in kernel.

One other comment - the description on the patches isn't quite accurate.  
The patches don't remove code duplication per se, they just replace some 
boilerplate code with a macro.


- Paul
