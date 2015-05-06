From: eddie.huang@mediatek.com (Eddie Huang)
Date: Wed, 6 May 2015 11:32:31 +0800
Subject: [rtc-linux] [PATCH v3 2/3] rtc: mediatek: Add MT6397 RTC driver
In-Reply-To: <20150505210131.GR4276@piout.net>
References: <1430206556-18254-1-git-send-email-eddie.huang@mediatek.com>
 <1430206556-18254-3-git-send-email-eddie.huang@mediatek.com>
 <20150505200010.GP4276@piout.net> <1430858661.9365.20.camel@perches.com>
 <20150505210131.GR4276@piout.net>
Message-ID: <1430883151.28521.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe and Alexandre,

On Tue, 2015-05-05 at 23:01 +0200, Alexandre Belloni wrote:
> On 05/05/2015 at 13:44:21 -0700, Joe Perches wrote :
> > I suggest moving the time_after() test into the loop,
> > use break; and remove the exit label too.
> > 
> > Maybe something like:
> > 
> > 	while (1) {
> > 		ret = regmap_read(rtc->regmap, rtc->addr_base + RTC_BBPU,
> > 				  &data);
> > 		if (ret < 0)
> > 			break;
> > 		if (!(data & RTC_BBPU_CBUSY))
> > 			break;
> > 		if (time_after(jiffies, timeout)) {
> > 			ret = -ETIMEDOUT;
> > 			break;
> > 		}
> > 		cpu_relax();
> > 	}
> > 
> > 	return ret;
> 
> That certainly looks more readable.
> 

Thanks correct me that I put wrong paramters in time_after, and give me
good example. I will adopt your suggestion in next round.

Eddie
