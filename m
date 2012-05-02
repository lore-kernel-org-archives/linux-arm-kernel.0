From: will.newton@gmail.com (Will Newton)
Date: Wed, 2 May 2012 10:07:45 +0100
Subject: [PATCH] mmc: dw_mmc: make multiple instances of
 dw_mci_card_workqueue
In-Reply-To: <1335909456-14020-1-git-send-email-thomas.abraham@linaro.org>
References: <1335909456-14020-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CAFbHwiSG6Z0aWuZvrydSjY07rgJpAuPx=9tzQDKc7UbaRTnY6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 1, 2012 at 10:57 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> The variable 'dw_mci_card_workqueue' is a global variable shared between
> multiple instances of the dw_mmc host controller. Due to this, data
> corruption has been noticed when multiple instances of dw_mmc controllers
> are actively reading/writing the media. Fix this by adding a instance
> of 'struct workqueue_struct' for each host instance and removing the
> global 'dw_mci_card_workqueue' instance.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
> ?drivers/mmc/host/dw_mmc.c ?| ? 14 ++++++--------
> ?include/linux/mmc/dw_mmc.h | ? ?1 +
> ?2 files changed, 7 insertions(+), 8 deletions(-)

Looks good.

Acked-by: Will Newton <will.newton@imgtec.com>
