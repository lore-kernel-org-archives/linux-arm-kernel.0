From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 5 Jul 2011 11:04:59 +0530
Subject: [RFC 5/8] remoteproc: add davinci implementation
In-Reply-To: <FFF198FBBF957F4393BA834040FEFFA202EC99@DFLE35.ent.ti.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-6-git-send-email-ohad@wizery.com>
	<4E035B78.3080200@mvista.com>
	<FFF198FBBF957F4393BA834040FEFFA202D66E@DFLE35.ent.ti.com>
	<4E04A9AE.3030801@mvista.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024D6C2F29@dbde02.ent.ti.com>
	<FFF198FBBF957F4393BA834040FEFFA202EC99@DFLE35.ent.ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D91A2CC@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, Jun 28, 2011 at 00:01:41, Grosen, Mark wrote:
> > From: Nori, Sekhar
> > Sent: Friday, June 24, 2011 8:44 AM
> > 
> > Hi Mark,
> 
> Sekhar, thanks for your feedback and ideas. Comments below.
> 
> Mark
> 
> > Since procedure to set the boot address varies across DaVinci
> > platforms, you could have a callback populated in platform data
> > which will be implemented differently for original DaVinci and
> > DA8xx devices.
> 
> I looked at DM6467 and it's the same as OMAPL13x, except at a different
> address. Rather than a callback, it could be just an address in the
> platform data.

Sounds okay as long as _all_ the DaVinci devices have the same
bit to be set. Plus, I hope there are no other users of the
register so that there is no race with other platform code using
the same register.

Thanks,
Sekhar
