From: dawei.chien@mediatek.com (dawei chien)
Date: Tue, 8 Sep 2015 23:46:35 +0800
Subject: thermal: mediatek: Add cpu power cooling model
In-Reply-To: <20150907060931.GF26760@linux>
References: <1441357309-61669-1-git-send-email-dawei.chien@mediatek.com>
 <20150907060931.GF26760@linux>
Message-ID: <1441727195.20470.40.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On Mon, 2015-09-07 at 11:39 +0530, Viresh Kumar wrote:
> On 04-09-15, 17:01, Dawei Chien wrote:
> > Use Intelligent Power Allocation (IPA) technical to add
> > static/dynamic power model for binding CPU thermal zone.
> > The power allocator governor allocates power budget to control
> > CPU temperature.
> 
> Sorry but this isn't enough really.. I don't have time to go through
> the code and understand the purpose of the series.
> 
> Please explain here in detail:
> - Why this is needed.
Power Allocator governor is able to keep SOC temperature within a
defined temperature range to avoid SOC overheat and keep it's
performance. mt8173-cpufreq.c need to register its' own power model with
power allocator thermal governor, so that power allocator governor can
allocates suitable power budget to control CPU temperature.

> - What/How you are doing it.
Measure and create dynamic/static power model, and register cooling
device of_cpufreq_power_cooling_register for MT8173.
> 
> (Don't resend, just reply to this email :) )
> 
