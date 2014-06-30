From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 30 Jun 2014 16:40:49 +0200
Subject: [PATCH v7 1/7] phy: add a driver for the Berlin SATA PHY
In-Reply-To: <20140630095940.GB10058@kwain>
References: <1403530783-17180-1-git-send-email-antoine.tenart@free-electrons.com>
 <1403530783-17180-2-git-send-email-antoine.tenart@free-electrons.com>
 <53AB1CFD.4040500@cogentembedded.com> <20140630095940.GB10058@kwain>
Message-ID: <53B176F1.5060308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30/2014 11:59 AM, Antoine T?nart wrote:
> On Wed, Jun 25, 2014 at 11:03:25PM +0400, Sergei Shtylyov wrote:
>> On 06/23/2014 05:39 PM, Antoine T?nart wrote:
>>> +	/* set the controller speed */
>>> +	writel(0x31, ctrl_reg + PORT_SCR_CTL);
>>
>>     Value undocumented? Or is this the SATA SControl register by chance?
>
> Some magic is still there...

Antoine,

I guess Sergei was referring to AHCI spec here. PORT_SCR bits are
documented in AHCI spec as:

7:4 = 0x3 Limit speed negotiation to a rate not greater than Gen3
           communication rate.

3:0 = 0x1 Perform interface communication sequence [...]. This is
           functionally equivalent to a hard reset [...].

So, the question is: Should we really need to reset controller in the
PHY driver or is it already done in AHCI common code? At least we
should change the comment to something like
/* set Gen3 controller speed and perform hard reset */

Sebastian
