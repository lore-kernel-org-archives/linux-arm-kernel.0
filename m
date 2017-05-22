From: kvalo@codeaurora.org (Kalle Valo)
Date: Mon, 22 May 2017 15:24:55 +0000 (UTC)
Subject: [15/16] hostap: convert hostap_cmd_queue.usecnt from atomic_t to
 refcount_t
In-Reply-To: <1490691403-4016-16-git-send-email-elena.reshetova@intel.com>
References: <1490691403-4016-16-git-send-email-elena.reshetova@intel.com>
Message-ID: <20170522152456.17EC860B7D@smtp.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Elena Reshetova <elena.reshetova@intel.com> wrote:
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

2 patches applied to wireless-drivers-next.git, thanks.

552aa585faff hostap: convert hostap_cmd_queue.usecnt from atomic_t to refcount_t
0aeffa7041d8 orinoco_usb: convert request_context.refcount from atomic_t to refcount_t

-- 
https://patchwork.kernel.org/patch/9648427/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
