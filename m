From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 19 May 2016 15:49:36 -0500
Subject: [PATCH] usb: echi-hcd: Add ehci_setup check before echi_shutdown
In-Reply-To: <1463652776-30456-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1463652776-30456-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <CAPBZ5QeK62Bs4Kh4UfQS=cmiGceb6gZcTSgOzncXL3f=ypZ3Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 May 2016 at 05:12, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> This patch protects system from crashing at shutdown in
> cases where usb host is not added yet from OTG controller driver.
> As ehci_setup() not done yet, so stop accessing registers or
> variables initialized as part of ehci_setup().
>
> The use case is simple, for boards like DB410c where the usb host
> or device functionality is decided based on the micro-usb cable
> presence. If the board boots up with micro-usb connected, the
> OTG driver like echi-msm would not add the usb host by default.
> However a system shutdown would go and access registers and
> uninitialized variables, resulting in below crash.

Works great.

Tested-by: Andy Gross <andy.gross@linaro.org>
