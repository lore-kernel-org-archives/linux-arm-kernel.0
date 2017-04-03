From: kvalo@codeaurora.org (Kalle Valo)
Date: Mon, 03 Apr 2017 14:38:49 +0300
Subject: [PATCH 15/16] drivers, net,
 intersil: convert hostap_cmd_queue.usecnt from atomic_t to refcount_t
In-Reply-To: <1490691403-4016-16-git-send-email-elena.reshetova@intel.com>
 (Elena Reshetova's message of "Tue, 28 Mar 2017 11:56:42 +0300")
References: <1490691403-4016-1-git-send-email-elena.reshetova@intel.com>
 <1490691403-4016-16-git-send-email-elena.reshetova@intel.com>
Message-ID: <874ly5oh4m.fsf@kamboji.qca.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Elena Reshetova <elena.reshetova@intel.com> writes:

> refcount_t type and corresponding API should be
> used instead of atomic_t when the variable is used as
> a reference counter. This allows to avoid accidental
> refcounter overflows that might lead to use-after-free
> situations.
>
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---
>  drivers/net/wireless/intersil/hostap/hostap_hw.c   | 12 ++++++------
>  drivers/net/wireless/intersil/hostap/hostap_wlan.h |  3 ++-
>  2 files changed, 8 insertions(+), 7 deletions(-)

The prefix should be "hostap:", I'll fix that.

-- 
Kalle Valo
