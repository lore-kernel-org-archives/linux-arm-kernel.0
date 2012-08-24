From: clemens@ladisch.de (Clemens Ladisch)
Date: Fri, 24 Aug 2012 09:15:00 +0200
Subject: [alsa-devel] [PATCH] ASoC: samsung dma - prepare dma in
 start/resume trigger path
In-Reply-To: <1345755069-9512-1-git-send-email-dgreid@chromium.org>
References: <1345755069-9512-1-git-send-email-dgreid@chromium.org>
Message-ID: <503729F4.5090805@ladisch.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dylan Reid wrote:
> On suspend all dma transactions are terminated (by the stop/suspend
> trigger calling ops->stop), they need to be set up again during resume.
> Move the prepare op to the start/resume/unpause trigger path so that dma
> and audio will restart on resume/unpause.

TRIGGER_RESUME must restart the stream at the buffer position at which
it was suspended.  If the driver is not capable of that, it must not
support TRIGGER_SUSPEND/RESUME in the first place (i.e., remove
SNDRV_PCM_INFO_RESUME).


Regards,
Clemens
