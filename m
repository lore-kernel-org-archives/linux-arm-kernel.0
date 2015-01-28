From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jan 2015 19:56:59 +0000
Subject: [PATCH 3/9] regulator: ab8500: move to set_optimum_mode
In-Reply-To: <1422413199-17273-4-git-send-email-bjorn.andersson@sonymobile.com>
References: <1422413199-17273-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1422413199-17273-4-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <20150128195658.GP21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 06:46:33PM -0800, Bjorn Andersson wrote:
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---
>  drivers/regulator/ab8500.c | 48 +++++++++++++++++++++++-----------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)

These refactorings are surprising and don't seem like an obvious
advantage - they mean that we now have two different paths to setting
the mode (one explict and the other via this).  For regulators that do
want to just do a lookup of a mode based on parameters I'd expect to
keep the operations separate in the same way that we do for things like
voltage setting in case we come up with ways of using the two bits
separately.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150128/263cc1e8/attachment-0001.sig>
