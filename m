From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sat, 16 Apr 2011 17:19:50 +0300
Subject: [PATCH 2/2] mtd: msm_nand: Add initial msm nand driver support.
In-Reply-To: <4DA96890.2070207@codeaurora.org>
References: <1298940450-27365-1-git-send-email-mnalajal@codeaurora.org>
	<1298940450-27365-2-git-send-email-mnalajal@codeaurora.org>
	<1302861097.3220.12.camel@localhost>  <4DA85B24.50807@codeaurora.org>
	<1302942029.2308.1.camel@koala>  <4DA96890.2070207@codeaurora.org>
Message-ID: <1302963590.2308.9.camel@koala>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Can i export this variable now?

I do not think so, we do not export random variables.

> What is your suggestion?

But I already did provide you suggestions - kill this global variable
completely. I provided the reasons:

1. It is error prone to hide functions behind something which looks like
a constant.
2. Multiple controllers with different base addresses wouldn't work -
your driver has to be able to at least theoretically handle multiple
controllers with different bases.

-- 
Best Regards,
Artem Bityutskiy (???????? ?????)
