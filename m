From: dianders@chromium.org (Doug Anderson)
Date: Mon, 20 Oct 2014 14:41:20 -0700
Subject: [PATCH v3 1/2] Revert "mfd: sec-core: Prepare regulators for
 suspend state to reduce power-consumption"
In-Reply-To: <1413839151-10875-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1413839151-10875-1-git-send-email-javier.martinez@collabora.co.uk>
 <1413839151-10875-2-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <CAD=FV=U+m_5JfXAJ6p_5k08R4=jzPgzcxnNr4PeEQQ6Z9Tbw=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier,

On Mon, Oct 20, 2014 at 2:05 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> This reverts commit b7cde7078d2344073c310aa65fc2b0a845d2cb5b
> ("mfd: sec-core: Prepare regulators for suspend state to reduce power-consumption")
>
> Commit b7cde7078d23 called regulator_suspend_prepare() to prepare the
> regulators for a suspend state. But it did from the device pm suspend
> handler while the regulator suspend prepare function iterates over all
> regulators and not only the one managed by this device so it doesn't
> seems to be correct to call it from within a device driver.
>
> It is better to call the regulator suspend prepare/finish functions
> from platform code instead so this patch reverts the mentioned commit.
>
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Reviewed-by: Doug Anderson <dianders@chromium.org>
