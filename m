From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 12 Apr 2016 13:51:55 +0200
Subject: [PATCH v5 16/46] pwm: move the enabled/disabled info into
 pwm_state
In-Reply-To: <1459368249-13241-17-git-send-email-boris.brezillon@free-electrons.com>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-17-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160412115155.GN18882@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2016 at 10:03:39PM +0200, Boris Brezillon wrote:
[...]
> @@ -145,7 +146,11 @@ static inline void pwm_get_state(const struct pwm_device *pwm,
>  
>  static inline bool pwm_is_enabled(const struct pwm_device *pwm)
>  {
> -	return test_bit(PWMF_ENABLED, &pwm->flags);
> +	struct pwm_state pstate;

No need for the p prefix, in my opinion.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160412/668f7c48/attachment-0001.sig>
