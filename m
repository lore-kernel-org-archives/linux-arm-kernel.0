From: micky_ching@realsil.com.cn (micky)
Date: Fri, 15 Nov 2013 11:43:01 +0800
Subject: [PATCH 1/4] mfd: rtsx: Generify call-back operations in orderto
 reduce code duplication
In-Reply-To: <1384421355-4434-2-git-send-email-lee.jones@linaro.org>
References: <1384421355-4434-1-git-send-email-lee.jones@linaro.org>
 <1384421355-4434-2-git-send-email-lee.jones@linaro.org>
Message-ID: <52859845.2020101@realsil.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2013 05:29 PM, Lee Jones wrote:
> +	if (rtl8411b_is_qfn48(pcr))
> +		set_pull_ctrl_tables(rtl8411b_qfn48);
> +	else
> +		set_pull_ctrl_tables(rtl8411b_qfn64);
Here will cause some problem, set_pull_ctrl_tables() include not a single
statements, will make the if-else not work correctly.

-- 
Best Regards
Micky.
