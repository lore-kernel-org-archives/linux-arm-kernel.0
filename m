From: broonie@kernel.org (Mark Brown)
Date: Sun, 21 Feb 2016 02:14:59 +0900
Subject: [PATCH 1/4] ASoC: wm9713: add binding for WM9713 codec
In-Reply-To: <1455979079-9030-1-git-send-email-robert.jarzmik@free.fr>
References: <1455979079-9030-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20160220171459.GA18327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 20, 2016 at 03:37:56PM +0100, Robert Jarzmik wrote:

> +WM9713 audio CODEC
> +
> +This devices supports I2C.

No, it clearly doesn't...  The problem with doing this is that since
AC'97 is an enumerable bus we really shouldn't need to list AC'97 CODECs
in the device tree.  Instead we should be probing at runtime (as the
non-ASoC AC'97 code does) or something similar.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160221/8be5e8ff/attachment.sig>
