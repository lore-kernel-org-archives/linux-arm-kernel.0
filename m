From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 06 Aug 2010 08:00:40 -0700
Subject: [PATCH V2] HRT support in Samsung S5P Platform
In-Reply-To: <AANLkTimiM3hbcA1_--rKKwqcOY-K=yef-VfgV2sSnqBG@mail.gmail.com>
References: <9852485.1007371280726519429.JavaMail.weblogic@epml04>
	<1281051440.30969.21.camel@c-dwalke-linux.qualcomm.com>
	<AANLkTimiM3hbcA1_--rKKwqcOY-K=yef-VfgV2sSnqBG@mail.gmail.com>
Message-ID: <1281106840.4236.1.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-08-06 at 09:19 +0900, Kyungmin Park wrote:
> On Fri, Aug 6, 2010 at 8:37 AM, Daniel Walker <dwalker@codeaurora.org> wrote:
> > On Mon, 2010-08-02 at 05:21 +0000, MADHAV SINGHCHAUHAN wrote:
> >> +config SAMSUNG_HRT_RTC_SYSTIMER
> >> +       bool "HRtimer and Dynamic Tick support"
> >> +       select GENERIC_TIME
> >> +       select GENERIC_CLOCKEVENTS
> >> +       select HIGH_RES_TIMERS
> >> +       help
> >> +          Support for HRtimer and Dynamic Tick system using RTC and
> >> SYSTEM timer
> >> +
> >
> > Do you really need a config option for this? I mean HRT has a config
> > option already ..
> 
> It mean which timer use for HRT. there are several combination to
> implement the HRT.
> Do you mean add the depends on HRT?

No .. You shouldn't need this config option at all. HRT should select
the right clock event device based on the rating. You just need to set
the rating correctly.

Daniel

-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
