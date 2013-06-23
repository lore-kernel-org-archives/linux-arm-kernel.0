From: ithamar@upgrade-android.com (Ithamar R. Adema)
Date: Sun, 23 Jun 2013 12:24:57 +0200
Subject: [PATCH] pinctrl-sunxi: fix pin attribute handling.
In-Reply-To: <20130623102057.GD26008@lukather>
References: <1371748373-10519-1-git-send-email-ithamar@upgrade-android.com>
 <20130620204908.GG2987@lukather>
 <A06309D9-3340-4F5B-AFB5-4B3DC3997411@upgrade-android.com>
 <20130623102057.GD26008@lukather>
Message-ID: <313777A7-CADC-4BE8-8ADD-9DFCEAB94E0B@upgrade-android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Maxime,

On Jun 23, 2013, at 12:20 , Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> While your reasoning is correct here, the point is that the platform is
> still a little obscure, with not a lot of documentation and so on. So
> relying on the bootloader to do some muxing could still prove useful.

Fair enough, I'll adjust this for sunxi then. The reason I'm asking is because I used this code for another architecture I hope to mainline (telechips) and I just wanted to know if this was some requirement of the subsystem or more related to the platform. Thanks for your explanation.

>> Just to make sure I understand, are you suggesting to stretch that
>> writel() onliner into an if (arg) writel() else writel() ?
> 
> Yes, something like
> 
> case PULL_UP:
>    val = readl(pctl->membase + sunxi_pull_reg(g->pin));
>    mask = PULL_PINS_MASK << sunxi_pull_offset(g->pin);
>    if (arg)
> 	writel((val & ~mask) | 1 << sunxi_pull_offset(g->pin), reg);
>    else
> 	writel(val & ~mask, reg);

Okay, clear.

I'll send a new patch along fixes the mentioned issues as suggested.

Thanks!

Regards,

Ithamar.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 4163 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130623/91f87caa/attachment.p7s>
