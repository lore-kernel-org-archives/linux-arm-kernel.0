From: robh@kernel.org (Rob Herring)
Date: Tue, 23 May 2017 08:45:07 -0500
Subject: [PATCH] Bluetooth: hci_ll: Fix download_firmware() return when
 __hci_cmd_sync fails
In-Reply-To: <20170522135042.10921-1-guodong.xu@linaro.org>
References: <20170522135042.10921-1-guodong.xu@linaro.org>
Message-ID: <CAL_Jsq+3buLUUigbHuP31Zgqxp-cdshcUYfxoRfG=oYBUbbc0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 8:50 AM, Guodong Xu <guodong.xu@linaro.org> wrote:
> When __hci_cmd_sync() fails, download_firmware() should also fail, and
> the same error value should be returned as PTR_ERR(skb).
>
> Without this fix, download_firmware() will return a success when it actually
> failed in __hci_cmd_sync().
>
> Fixes: 371805522f87 ("bluetooth: hci_uart: add LL protocol serdev driver support")
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> ---
>  drivers/bluetooth/hci_ll.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
