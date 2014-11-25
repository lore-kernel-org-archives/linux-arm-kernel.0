From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 25 Nov 2014 17:23:59 +0100
Subject: [PATCH 0/2] Increase the maximum cpu frequency of rk3288
In-Reply-To: <5474AAB4.2060301@rock-chips.com>
References: <1416908253-31721-1-git-send-email-zyw@rock-chips.com>
 <5474AAB4.2060301@rock-chips.com>
Message-ID: <3297542.UgVU3NH89O@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris, Kever,

Am Mittwoch, 26. November 2014, 00:13:40 schrieb Kever Yang:
> On 11/25/2014 05:37 PM, Chris Zhong wrote:
> > The maximum cpu frequency of rk3288 can up to 1.8Ghz, but the vdd_cpu need
> > set to 1.4v. I've tested these patches on rk3288 evb board.
> 
> I'm not sure why you need this patch, I think we have a discuss
> for the cpu operating point before.
> In this case:
> 1. rk3288.dtsi is for all the rk3288 Soc based system, you may need
> a separate opp table in rk3288-evb-rk808.dts;
> 2. 1.4V may beyond the supported voltage range too much,
>      and it's not a good idea to add it to rk3288.dtsi as a safe voltage.
> 3. Do you have a stress/heavy load test on evb with 1.4v at 1.8GHz?

That is how I remember it as well ... the default opp table is supposed to 
contain only the safest of values, while individual boards can then increase 
those in conjunction with their thermal design.

As the evb itself does only have the naked soc without any heat-sink or 
similar, I'm not even sure if these additional frequencies should be enabled 
there at all.


Heiko
