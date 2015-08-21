From: axel.lin@ingics.com (Axel Lin)
Date: Fri, 21 Aug 2015 13:08:24 +0800
Subject: [PATCH v3] pinctrl: mediatek: Fix multiple registration issue.
In-Reply-To: <1440132404-27749-1-git-send-email-hongzhou.yang@mediatek.com>
References: <1440132404-27749-1-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <CAFRkauDR_XuMrihptQu1=Oq4nzOqcmne89LwsOHPzQrWCQQgMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-08-21 12:46 GMT+08:00 Hongzhou Yang <hongzhou.yang@mediatek.com>:
> Since our common driver need support main chip and PMU
> at the same time, that means it will register two
> pinctrl device, and the pinctrl_desc structure should
> be used two times.
>
> But pinctrl_desc use global static definition, then
> the latest registered pinctrl device will overwrite
> the old one's, all members in pinctrl_desc will set to
> the new one's, such as name, pins and pins numbers, etc.
> This is a bug. Changing to use devm_kzalloc to fix it.
>
> Cc: stable at vger.kernel.org # v4.1+
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
> ---
>  Use dynamic allocation to fix multiple registration issue.

The code looks good to me but the commit log needs fix.
You don't use devm_kzalloc now.
Just embedded struct pinctrl_desc pctl_desc to struct mtk_pinctrl.

Reviewed-by: Axel Lin <axel.lin@ingics.com>
