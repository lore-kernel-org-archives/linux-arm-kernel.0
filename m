From: dianders@chromium.org (Doug Anderson)
Date: Thu, 18 Dec 2014 16:20:15 -0800
Subject: [PATCH 2/3] mmc: dw_mmc: Generic MMC tuning with the clock phase
 framework
In-Reply-To: <1418943663-10012-3-git-send-email-amstan@chromium.org>
References: <1418943663-10012-1-git-send-email-amstan@chromium.org>
 <1418943663-10012-3-git-send-email-amstan@chromium.org>
Message-ID: <CAD=FV=WhB84enspDCHwkc2TqEFeAr_qiY4m_xYvMYCArUAtPXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alex,

On Thu, Dec 18, 2014 at 3:01 PM, Alexandru M Stan <amstan@chromium.org> wrote:
> +       blk_test = kmalloc(blksz, GFP_KERNEL);
> +       if (!blk_test)
> +               return -ENOMEM;
> +
> +       ranges = kmalloc(((NUM_PHASES / 2 + 1) * sizeof(ranges)), GFP_KERNEL);

sizeof(*ranges)


Other than that, this looks good to me and you can add my reviewed-by
when the above is fixed.
