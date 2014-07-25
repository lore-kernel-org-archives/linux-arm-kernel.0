From: broonie@kernel.org (Mark Brown)
Date: Fri, 25 Jul 2014 18:55:05 +0100
Subject: [PATCH 1/1] ASoC: sirf-usp: Fixed a bug for playback and capture
 work at the same time
In-Reply-To: <1406092772-26371-1-git-send-email-rongjun.ying@csr.com>
References: <1406092772-26371-1-git-send-email-rongjun.ying@csr.com>
Message-ID: <20140725175505.GH17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 23, 2014 at 01:19:32PM +0800, Rongjun Ying wrote:
> 1. The startup function invoked when the playback and capture.
>    If start playback when capturing, the registers are re-initinitialised.
>    That cause the playback fail. So move the startup code into runtime resume.
> 2. Modified: If non RUNTIME_PM support, the probe need enable clock and
>    initinitialise registers.
> 3. Refine code.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140725/b00107b8/attachment-0001.sig>
