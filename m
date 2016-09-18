From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sun, 18 Sep 2016 18:05:59 +0200
Subject: [PATCH V5 2/6] thermal: bcm2835: add thermal driver for bcm2835
 soc
In-Reply-To: <1999564031.209213.6508fbdb-00c5-486b-a34e-3d60ae68fe88.open-xchange@email.1und1.de>
References: <1473759262-27031-1-git-send-email-kernel@martin.sperl.org>
 <1473759262-27031-3-git-send-email-kernel@martin.sperl.org>
 <1999564031.209213.6508fbdb-00c5-486b-a34e-3d60ae68fe88.open-xchange@email.1und1.de>
Message-ID: <4D9CBC7C-FB79-4B3F-8896-4E8341763248@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan!

> On 18.09.2016, at 13:31, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> 
>> +	rate = clk_get_rate(data->clk);
>> +	if ((rate < 1920000) || (rate > 5000000)) {
>> +		dev_warn(&pdev->dev,
>> +			 "Clock %pCn is running at %pCr Hz, which is outside the recommended range
>> of 1.9 to 5.0 MHz\n",
>> +			 data->clk, data->clk);
> 
> Instead of printing the clock name twice your intension would be to print the
> actual clock rate?
%pCn (and %pC) prints the clock name
%pCr prints the clock rate - I guess I could use ?%lu? and rate instead

So I do not see an issue here - I will reword the text to shorten it.

Everything else I will fix as mentioned.

Martin
