From: ming.lei@canonical.com (Ming Lei)
Date: Tue, 11 Feb 2014 10:30:51 +0800
Subject: [RFC PATCH V2 4/4] arm64: mm: implement get_user_pages_fast
In-Reply-To: <1391703531-12845-5-git-send-email-steve.capper@linaro.org>
References: <1391703531-12845-1-git-send-email-steve.capper@linaro.org>
 <1391703531-12845-5-git-send-email-steve.capper@linaro.org>
Message-ID: <CACVXFVPw0k1Jj0zHBP3AuuM15aUiXNZBo78DyO8cRHXx7mwFXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 7, 2014 at 12:18 AM, Steve Capper <steve.capper@linaro.org> wrote:
> An implementation of get_user_pages_fast for arm64. It is based on the
> arm implementation (it has the added ability to walk huge puds) which
> is loosely on the PowerPC implementation. We disable interrupts in the
> walker to prevent the call_rcu_sched pagetable freeing code from
> running under us.
>
> We also explicitly fire an IPI in the Transparent HugePage splitting
> case to prevent splits from interfering with the fast_gup walker.
> As THP splits are relatively rare, this should not have a noticable
> overhead.
>
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Tested-by: Ming Lei <ming.lei@canonical.com>

Thanks,
--
Ming Lei
