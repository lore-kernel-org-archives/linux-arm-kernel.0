From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Tue, 29 Mar 2011 21:40:27 -0700
Subject: [PATCH] msm: watchdog: support watchdog on 8x60 and 8960
In-Reply-To: <1301426560.4049.0.camel@m0nster>
References: <1301105894-22835-1-git-send-email-johlstei@codeaurora.org>
	<1301426560.4049.0.camel@m0nster>
Message-ID: <4D92B43B.5050101@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Walker wrote:
> Are you saying this is mostly a debugging facility ? The interrupts off
> thing I can see as just debugging, but I don't understand the bus
> lockups part.
>   

It isn't just a debugging facility. It is still beneficial to the end user
in that it restarts the system if there is a bus lockup or a faulty 
interrupt
handler in a rarely used codepath. This is better than the alternative 
of draining
the battery and turning off. We want this to be turned on independent of 
what userspace
one is using, unless they explicitly turn it off themselves.

Jeff

--- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
