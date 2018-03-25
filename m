From: michael.chan@broadcom.com (Michael Chan)
Date: Sun, 25 Mar 2018 13:24:12 -0700
Subject: [PATCH v7 6/7] bnxt_en: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1521988761-30344-7-git-send-email-okaya@codeaurora.org>
References: <1521988761-30344-1-git-send-email-okaya@codeaurora.org>
 <1521988761-30344-7-git-send-email-okaya@codeaurora.org>
Message-ID: <CACKFLinfo5xieJB_bgwXQhCCySZcGFpG2daqNcpX3gjgDKMdFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 25, 2018 at 7:39 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Code includes wmb() followed by writel(). writel() already has a barrier on
> some architectures like arm64.
>
> This ends up CPU observing two barriers back to back before executing the
> register write.
>
> Create a new wrapper function with relaxed write operator. Use the new
> wrapper when a write is following a wmb().
>
> Since code already has an explicit barrier call, changing writel() to
> writel_relaxed().
>
> Also add mmiowb() so that write code doesn't move outside of scope.

This line in the patch description is not needed anymore.  Other than that,

Acked-by: Michael Chan <michael.chan@broadcom.com>

Thanks.
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
