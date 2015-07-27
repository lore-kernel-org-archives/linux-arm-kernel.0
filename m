From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 27 Jul 2015 13:14:34 +0200
Subject: [PATCH v2 2/7] cpufreq: opp: fix handling of turbo modes
In-Reply-To: <20150727103521.GA4103@linux>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <1595601.YD6UTxy5Qg@amdc1976> <20150727103521.GA4103@linux>
Message-ID: <3141301.RS9TLygaba@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Monday, July 27, 2015 04:05:21 PM Viresh Kumar wrote:
> On 27-07-15, 12:24, Bartlomiej Zolnierkiewicz wrote:
> > Have you read my explanation of the issue?
> > 
> > With your OPP-v2 patches cpufreq-dt picks turbo frequencies and uses
> > them as normal ones.
> > 
> > (More at: http://www.spinics.net/lists/arm-kernel/msg430397.html)
> 
> Yes I did. I understand that the turbo frequencies are not considered
> as such by OPP/cpufreq core and it requires your changes to get it
> working.

Sorry but you don't seem to understand the issue.

The problem is that without my patch and with your OPP-v2 patches
turbo frequencies get picked by OPP/cpufreq core and then by cpufreq-dt.
This happens without enabling any boost & thermal etc. support for
turbo frequencies.

> But its not an issue or bug we are fixing, the problem is that the
> code for opp-v2 isn't complete yet and your patches is putting things
> in place. So, we are still doing the bring up here and not fixing a
> bug really.

I consider the possibility to use turbo frequencies without explicitly
enabling boost support to be a buggy behavior.  While it is unlikely
that somebody defines turbo frequencies in their dts file in the near
future (except Exynos ones) it costs as nearly nothing to prevent
such behavior now.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
