From: kubakici@wp.pl (Kuba Kicinski)
Date: Thu, 25 Feb 2016 18:36:31 -0500
Subject: [PATCH][V3] mt7601u: do not free dma_buf when ivp allocation fails
In-Reply-To: <1456442667-19751-1-git-send-email-colin.king@canonical.com>
References: <1456442667-19751-1-git-send-email-colin.king@canonical.com>
Message-ID: <286FE43B-A725-4BE0-B490-E91A107F8D0B@wp.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 February 2016 18:24:27 GMT-05:00, Colin King <colin.king@canonical.com> wrote:
>From: Colin Ian King <colin.king@canonical.com>
>
>If the allocation of ivp fails the error handling attempts to
>free an uninitialized dma_buf; this data structure just contains
>garbage on the stack, so the freeing will cause issues when the
>urb, buf and dma fields are free'd. Fix this by not free'ing the
>dma_buf if the ivp allocation fails.
>
>Signed-off-by: Colin Ian King <colin.king@canonical.com>

LGTM, thanks.
