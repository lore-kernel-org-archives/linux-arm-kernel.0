From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 29 Dec 2011 10:31:58 +0000
Subject: [PATCH] ARM: S3C64XX: Reduce residency requirement for cpuidle
 WFI mode
In-Reply-To: <028a01ccc5da$6bdeaec0$439c0c40$%kim@samsung.com>
References: <1324897126-8889-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <028a01ccc5da$6bdeaec0$439c0c40$%kim@samsung.com>
Message-ID: <20111229103157.GA2909@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2011 at 12:31:58PM +0900, Kukjin Kim wrote:
> Mark Brown wrote:

> > Entering and leaving WFI is really cheap so there's no reason to have much
> > of a residency requirement for the state. Lower it to 1ms.

> > -		.target_residency	= 100000,
> > +		.target_residency	= 1,

> OK, will apply.
> Mark, do you want to send this before v3.2?

It doesn't seem super urgent, though it'd be nice to get it into 3.3
with the original patch adding the support.
