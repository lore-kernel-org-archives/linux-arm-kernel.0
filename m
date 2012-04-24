From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 24 Apr 2012 13:04:27 -0600
Subject: [PATCH v2 2/2] pinctrl: remove the old pinctrl dt dummy state
 interfaces
In-Reply-To: <1335260023-15859-2-git-send-email-b29396@freescale.com>
References: <1335260023-15859-1-git-send-email-b29396@freescale.com>
 <1335260023-15859-2-git-send-email-b29396@freescale.com>
Message-ID: <4F96F93B.2020603@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2012 03:33 AM, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> We already have pinctrl_provide_dummies, so remove the old
> one to avoid diversity.

Nak, if I may be so bold.

> Hi Stephen,
> I removed the old dt pinctrl dummy sate interface.
> The purpose is to get a unified way to handle pinctrl dummy state.

Well, there are two completely different scenarios being covered here,
and I don't think it makes sense to unify them:

1) Platform under development without complete pinctrl support yet
(covered by patch 1 in this series).

2) Platform with complete pinctrl support, but using some common HW
modules whose drivers need to use pinctrl on some platforms, but not on
all, so that dummy states are required. This patch removes the ability
to correctly represent this situation.

> One disadvantage is that we may not meet the requirement
> that for platform which only want to use dummy state for some specific
> devices while not affect others. For this case, it may reply on users
> to refer to the pinctrl debug message to see which devices are using
> dummy state while which are not.
> However, if keep it we may have two type of user interface to handle
> dummy state which i'm not sure is a good thing. And as regulator also
> does not provide per device dummies, so i removed it first.

Well, first I'd say that if regulator didn't have this feature, it'd
probably just be a missing feature in regulator, and not a good
justification for removing the feature from pinctrl.

But that said, regulator does in fact have this feature - it's called
the fixed regulator.

> What's your suggestion on it?
> I reform this clean up into a separate patch, if you do not like it,
> we can drop it later.

I'd love to drop it, please.
