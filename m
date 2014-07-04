From: broonie@kernel.org (Mark Brown)
Date: Fri, 4 Jul 2014 20:29:47 +0100
Subject: [PATCH] ASoC: samsung: Correct I2S DAI suspend/resume ops
In-Reply-To: <1404482745-29177-1-git-send-email-s.nawrocki@samsung.com>
References: <1404482745-29177-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20140704192947.GG14896@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 04:05:45PM +0200, Sylwester Nawrocki wrote:
> We should save/restore relevant I2S registers regardless of
> the dai->active flag, otherwise some settings are being lost
> after system suspend/resume cycle. E.g. I2S slave mode set only
> during dai initialization is not preserved and the device ends
> up in master mode after system resume.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140704/8a3d9d20/attachment.sig>
