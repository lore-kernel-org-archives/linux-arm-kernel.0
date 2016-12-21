From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 21 Dec 2016 10:44:49 +0100
Subject: [PATCH v2] rtc: armada38x: Followed the new recommendation for
 errata implementation
In-Reply-To: <87tw9xiri9.fsf@free-electrons.com>
References: <20161213112510.25692-1-gregory.clement@free-electrons.com>
 <20161221004308.terkq5u5pb2hbcbw@piout.net>
 <87tw9xiri9.fsf@free-electrons.com>
Message-ID: <20161221094449.gllgbgroopxmtnmp@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/12/2016 at 10:02:54 +0100, Gregory CLEMENT wrote :
> Hi Alexandre,
>  
>  On mer., d?c. 21 2016, Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> 
> 
> I agree with all your remark expect one, see below:
> [...]
> >>  	rtc_update_irq(rtc->rtc_dev, 1, event);
> >>  
> >>  	return IRQ_HANDLED;
> >> @@ -221,6 +282,11 @@ static __init int armada38x_rtc_probe(struct platform_device *pdev)
> >>  	if (!rtc)
> >>  		return -ENOMEM;
> >>  
> >> +	rtc->val_to_freq = devm_kcalloc(&pdev->dev, SAMPLE_NR,
> >> +				sizeof(struct value_to_freq), GFP_KERNEL);
> >> +	if (!rtc->val_to_freq)
> >> +		return -ENOMEM;
> >> +
> >
> > The whole struct armada38x_rtc is already allocated just before. Maybe
> > you can put the whole array inside the structure instead of doing a new
> > allocation.
> 
> Actually it was done on purpose. Indeed the same RTC IP is used in the
> Armada 3700 (a patch is coming soon), and for this IP this issue was
> fixed and we do not need to store 100 read. That's why I want to
> allocate the array only if needed.
> 

Fair enough


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
