From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Mar 2016 10:28:56 +0700
Subject: [PATCH] pinctrl: lpc18xx: ensure ngroups is initialized at
 correct place
In-Reply-To: <1456335170-20718-1-git-send-email-colin.king@canonical.com>
References: <1456335170-20718-1-git-send-email-colin.king@canonical.com>
Message-ID: <CACRpkdYxFm06aCUwf-stH4fmJdqS25Ek=9i0CVwR4JcSYPtLEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2016 at 12:32 AM, Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> The initialization of ngroups is occurring at the end of the
> first iteration of the outer loop, which means that the
> assignment  pins[ngroups++] = i is potentially indexing into
> a region outside of array pins because ngroups is not initialized.
> Instead, initialize ngroups in the inner loop before the first
> inner loop iteration.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied with Joachim's review tag.

Yours,
Linus Walleij
