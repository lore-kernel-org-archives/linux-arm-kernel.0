From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 1 Aug 2012 10:46:33 +0800
Subject: [alsa-devel] [PATCH 1/1] ASoC: sgtl5000: enable VAG_POWER for
 LINE_IN
In-Reply-To: <20120728143957.GJ2128@S2101-09.ap.freescale.net>
References: <1343387922-25227-1-git-send-email-b29396@freescale.com>
 <20120728143957.GJ2128@S2101-09.ap.freescale.net>
Message-ID: <20120801024630.GA30492@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 28, 2012 at 10:39:59PM +0800, Shawn Guo wrote:
> On Fri, Jul 27, 2012 at 07:18:42PM +0800, Dong Aisheng wrote:
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> > 
> > LINE_IN also needs VAG_POWER on or we may hear noise when directly
> > route LINE_IN to Headphone Mux.
> 
> The following is what I see from sgtl5000 data sheet about VAG_POWER.
> 
>   VAG is the internal voltage reference for the ADC and DAC.
> 
> Are you seeing any info that requires VAG_POWER in route of LINE_IN to
> Headphone Mux?  Or it's only a result from your testing?
> 
No, it's from the test result.
Maybe i should have added a FIXME for this.

> Does it also fix the noise issue you mentioned with normal recording
> (LINE_IN to ADC) before?
> 
ADC also needs VAG power which already fixed by:
commit f0cdcf3 (ASoC: sgtl5000: Enable VAG when DAC/ADC up)
This patch is only for direct LINE_IN to Headphone Mux.

Regards
Dong Aisheng
