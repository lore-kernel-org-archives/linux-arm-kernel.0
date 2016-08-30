From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 30 Aug 2016 10:24:18 +0100
Subject: [PATCH 1/2] jump_labels: Allow array initialisers
In-Reply-To: <1472145992-10660-2-git-send-email-catalin.marinas@arm.com>
References: <1472145992-10660-1-git-send-email-catalin.marinas@arm.com>
 <1472145992-10660-2-git-send-email-catalin.marinas@arm.com>
Message-ID: <20160830092417.GE5163@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2016 at 06:26:31PM +0100, Catalin Marinas wrote:
> diff --git a/Documentation/static-keys.txt b/Documentation/static-keys.txt
> index 477927becacb..fd490f8b1cfa 100644
> --- a/Documentation/static-keys.txt
> +++ b/Documentation/static-keys.txt
> @@ -15,6 +15,8 @@ The updated API replacements are:
>  
>  DEFINE_STATIC_KEY_TRUE(key);
>  DEFINE_STATIC_KEY_FALSE(key);
> +DEFINE_STATIC_KEY_ARRAY_TRUE(keys, count);
> +DEFINE_STATIC_KEY_ARRAY_FALSE(keys, count);
>  static_branch_likely()
>  static_branch_unlikely()
>  
> @@ -140,6 +142,12 @@ static_branch_inc(), will change the branch back to true. Likewise, if the
>  key is initialized false, a 'static_branch_inc()', will change the branch to
>  true. And then a 'static_branch_dec()', will again make the branch false.
>  
> +Where an array of keys is required, it can be defined as:
> +
> +	DEFINE_STATIC_KEY_ARRAY_TRUE(keys, count);
> +
> +or:
> +	DEFINE_STATIC_KEY_ARRAY_FALSE(keys, count);

Nitpick to myself: for consistency, we need an empty line between "or:"
and "DEFINE_STATIC_KEY_ARRAY_FALSE" (I fixed it locally).

-- 
Catalin
