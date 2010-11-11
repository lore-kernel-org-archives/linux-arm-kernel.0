From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Thu, 11 Nov 2010 13:59:00 +0100
Subject: [AT91SAM9260] kernel hang in at91sam926x_pit_reset()
In-Reply-To: <AANLkTi=ahWs+VidZpjPEBfUs5RZkv18XMDB0jCgrHA_r@mail.gmail.com>
References: <AANLkTik1P9CNYu93ZDc3PU6e=17O8XBg=DdPo1a9VW6c@mail.gmail.com>
	<201011111345.42080.alexander.stein@systec-electronic.com>
	<AANLkTi=ahWs+VidZpjPEBfUs5RZkv18XMDB0jCgrHA_r@mail.gmail.com>
Message-ID: <201011111400.15767.alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 November 2010, 13:50:12 Vitja Makarov wrote:
> > This won't work as you cannot set PIT_PITEN until the PIT has stopped
> > (UserManuel 17.3), read as CPIV is 0. You should check if and why CPIV
> > isn't increasing.
> > 
> > Best regards
> > Alexander
> 
> Could it be hardware bug? With revision A it works. Do you have
> success on use rev B. CPUs?
> May be the problem is in u-boot or initial loader?

We don't use 9260 actually, we use the successor 9g20. Have you read the 
errata ? And yes, it could be a problem in u-boot or your other loader.
But AFAIK u-boot uses the PIT as a free running timer to get a time base.

Best regards,
Alexander
