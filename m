From: rabin.vincent@stericsson.com (Rabin VINCENT)
Date: Mon, 17 May 2010 10:50:22 +0530
Subject: [PATCH] gic: implement set_type
In-Reply-To: <4BED7B00.5080405@codeaurora.org>
References: <1273574921-25714-1-git-send-email-rabin.vincent@stericsson.com>
	<4BED7B00.5080405@codeaurora.org>
Message-ID: <20100517052021.GA4597@bnru02.bnr.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 14, 2010 at 06:32:00PM +0200, Abhijeet Dharmapurikar wrote:
> > +	/* Only SPIs' interrupt configuration can be changed */
> > +	if (gicirq < 32)
> > +		return -EINVAL;
> 
> This causes drivers who are requesting PPI's with IRQF_TRIGGER_* flags 
> to fail.
> 
> Note that it is "Implementation Defined" whether PPI's are programmable 
> .http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ihi0048a/index.html
> 
> I would request to change gicirq < 32 to gicirq < 16 , the writes will 
> be ignored if PPI's are not programmable.

New patch below:
