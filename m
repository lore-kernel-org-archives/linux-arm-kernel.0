From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Wed, 02 Feb 2011 22:26:17 +0100
Subject: i.MX & IRQF_ONESHOT
In-Reply-To: <20110202212000.GA30452@pengutronix.de>
References: <20110113091355.GP24920@pengutronix.de>
	<4D2EDE10.3040809@atmel.com>
	<alpine.LFD.2.00.1101131839010.2678@localhost6.localdomain6>
	<4D2F6AB7.30800@eukrea.com> <20110113212401.GZ24920@pengutronix.de>
	<4D2FFCBE.3010704@eukrea.com>
	<alpine.LFD.2.00.1101141138480.2678@localhost6.localdomain6>
	<20110114130821.GA1434@pengutronix.de>
	<20110202212000.GA30452@pengutronix.de>
Message-ID: <4D49CBF9.6000904@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On 02/02/2011 22:20, Uwe Kleine-K?nig wrote:
> On Fri, Jan 14, 2011 at 02:08:21PM +0100, Uwe Kleine-K?nig wrote:
>> Hello,
>>
>> On Fri, Jan 14, 2011 at 11:57:34AM +0100, Thomas Gleixner wrote:
>>> So there are several things wrong here:
>>>
>>> 1) Using handle_level_irq for an edge interrupt is wrong. That's not
>>>     restricted to the TS driver problem at hand. That's wrong in
>>>     general. Other set_type() functions adjust the handler as well when
>>>     they switch the edge/level types.
>> That was introduced by 060d20d32ae7c6a20a8eac465795ed5bc9b37f7c.
>> As a quick test you can try to revert that.  If that helps I can look
>> deeper into it.  That won't help on at91 though.
> Eric, did you resolve the problem, did reverting 060d20d32ae7c6 help?
>
Sorry, I didn't have the time to test yet.
I'll try to test this and provide feedback before the end of the week.

Best regards,
Eric
