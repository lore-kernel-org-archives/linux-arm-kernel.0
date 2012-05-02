From: will.newton@gmail.com (Will Newton)
Date: Wed, 2 May 2012 10:10:25 +0100
Subject: [PATCH 2/7] mmc: dw_mmc: add quirk to indicate missing write
 protect line
In-Reply-To: <1335935266-25289-3-git-send-email-thomas.abraham@linaro.org>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
 <1335935266-25289-3-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CAFbHwiTRzGJgxxMAkqDDM-fPxgGe1bC3yKWCM+bNp3-i7WWcZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 2, 2012 at 6:07 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> If the write protect pad of the controller is not connected to the write
> protect pin of the slot, the driver should be notified of this condition
> so that incorrect check for write protection by reading the WRTORT
> register can avoided. The get_ro platform callback can be used for in
> such cases, but with device tree support enabled, such platform callbacks
> cannot be supported.
>
> Add a new quirk for notifying the driver about the missing write protect
> line so the driver can assume that the card write protection is disabled.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
> ?drivers/mmc/host/dw_mmc.c ?| ? ?4 +++-
> ?include/linux/mmc/dw_mmc.h | ? ?3 ++-
> ?2 files changed, 5 insertions(+), 2 deletions(-)

Acked-by: Will Newton <will.newton@imgtec.com>
