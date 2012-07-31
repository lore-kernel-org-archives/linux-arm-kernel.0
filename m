From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 31 Jul 2012 15:54:44 +0100
Subject: [PATCH 1/6] ASoC: dapm: If one widget fails, do not force all
 subsequent widgets to fail too
In-Reply-To: <5017EDCA.4020601@linaro.org>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <1343741493-17671-3-git-send-email-lee.jones@linaro.org>
 <20120731134214.GK4468@opensource.wolfsonmicro.com>
 <5017EAC3.3080504@linaro.org>
 <20120731142820.GW4468@opensource.wolfsonmicro.com>
 <5017EDCA.4020601@linaro.org>
Message-ID: <20120731145443.GY4468@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 03:38:02PM +0100, Lee Jones wrote:

> Neither of those are in my Inbox. Blame Mozilla. :)

You might want to look at a better mail program.

> It's better because the whole audio system doesn't fail in the case
> of minor failure. It'd be like calling off a football game (or
> whatever you're into) because one of the substitutes ruptured an
> eyelash.

It shouldn't make any difference to startup - we should still be
checking errors and failing the init if we're failing to add links, 
this isn't something that's likely to randomly break on a particular
boot, it's more something that indicates nobody bothered testing.

It's certainly totally inappropriate for an "urgent" bugfix.

> During start-up the ux500 has a couple of very unimportant widgets
> fail. It's the wrong behavior to force failure on the everything
> audio just because of that.

Fixes for those errors, however...
