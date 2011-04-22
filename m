From: skannan@codeaurora.org (Saravana Kannan)
Date: Fri, 22 Apr 2011 15:26:25 -0700
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <alpine.LFD.2.02.1104221857060.3323@ionos>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>	<alpine.LFD.2.02.1104201704350.3323@ionos>	<20110420185922.GD31131@pengutronix.de>	<alpine.LFD.2.02.1104202113250.3323@ionos>	<20110421074214.GE15233@pengutronix.de>	<alpine.LFD.2.02.1104211113030.3323@ionos>	<20110421120656.GF15233@pengutronix.de>	<alpine.LFD.2.02.1104211632240.3323@ionos>	<BANLkTikU9RLy9VR+tOPMt0u6zJp-bW5_Cw@mail.gmail.com>	<alpine.LFD.2.02.1104221124270.3323@ionos>	<BANLkTim8GUuMxwfHFoVv=LfQFuh4QaPn+Q@mail.gmail.com>
	<alpine.LFD.2.02.1104221857060.3323@ionos>
Message-ID: <4DB20091.1070509@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2011 09:57 AM, Thomas Gleixner wrote:
> On Fri, 22 Apr 2011, Colin Cross wrote:
>
>> On Fri, Apr 22, 2011 at 2:51 AM, Thomas Gleixner<tglx@linutronix.de>  wrote:
>>> Another thing I'm pondering is to provide the ability to maintain
>>> separate clk trees. So you can have individual domains which have
>>> their per clk tree locking. Would that make sense ?
>>
>> Clock trees are likely to be linked somewhere - an external clock chip
>> that drives the main clock input on the SoC, or an SoC clock output
>> that drives a chip with an internal clock tree.  Domains would have to
>> be dynamically managed to ensure two clocks from different clock chips
>> that become linked are moved under the same clock lock.  Probably
>> easier to keep a global lock.
>
> Ok. It's easy enough to split later if the need arises.

MSM certainly has the need for having independent clock trees. I would 
like support for this to be in from the start otherwise it's going to 
really screw clocks in one of the trees.

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
