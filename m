From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 12 Feb 2015 01:33:39 +0300
Subject: -n900 (not mainline): fix compilation with 3.20-rc0
In-Reply-To: <20150211222342.GE11313@amd>
References: <20150211222342.GE11313@amd>
Message-ID: <54DBD8C3.4090904@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02/12/2015 01:23 AM, Pavel Machek wrote:

    This looked like a patch in its final form, so I decided to comment on it...

> commit 02aa41563bd0f14268d2142ab69694880d3425a1
> Author: Pavel <pavel@ucw.cz>
> Date:   Wed Feb 11 23:22:51 2015 +0100

    No need for this header.

>      Fix compilation of wl1251 specific parts with 3.20-rc0.

>      Signed-off-by: Pavel Machek <pavel@ucw.cz>

    Please don't indent the change log.

> diff --git a/drivers/net/wireless/ti/wl1251/netlink.c b/drivers/net/wireless/ti/wl1251/netlink.c
> index e5f5a45..90a5486 100644
> --- a/drivers/net/wireless/ti/wl1251/netlink.c
> +++ b/drivers/net/wireless/ti/wl1251/netlink.c
[...]
> @@ -406,14 +398,10 @@ static int wl1251_nl_phy_reg_read(struct sk_buff *skb, struct genl_info *info)
>   	if (nla_put_u32(msg, WL1251_NL_ATTR_REG_VAL, *reg_value))
>   		goto nla_put_failure;
>
> -	ret = genlmsg_end(msg, hdr);
> -	if (ret < 0) {
> -		wl1251_error("%s() failed", __func__);
> -		goto nla_put_failure;
> -	}
> +	genlmsg_end(msg, hdr);
>
>   	kfree(reg_value);
> -
> +	

    Remove this stray tab please.

>   	return genlmsg_reply(msg, info);
>
>   nla_put_failure:

WBR, Sergei
