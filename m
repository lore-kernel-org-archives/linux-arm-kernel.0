From: dirk.behme@googlemail.com (Dirk Behme)
Date: Fri, 18 May 2012 08:16:19 +0200
Subject: Booting mx31 on linux-next-20120517
In-Reply-To: <20120518060056.GB3710@pengutronix.de>
References: <CAOMZO5C2vf-emmk=aALy7VESnBkVAQ23YXkHP31MMK7JQzd3Ag@mail.gmail.com>
 <CAOMZO5BUBAcx9ESLau9b4osE3jQNnh1CXW7FgkmbQ1aS57bOCg@mail.gmail.com>
 <20120518060056.GB3710@pengutronix.de>
Message-ID: <4FB5E933.6060001@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.05.2012 08:00, Uwe Kleine-K?nig wrote:
> On Fri, May 18, 2012 at 01:07:07AM -0300, Fabio Estevam wrote:
>> initlevel:7=late, 20 registered initcalls
>> VFP support v0.3: implementor 41 architecture 1 part 20 variant b rev 2
>> turn off boot console earlycon
>>
>> How can we prevent the "turn off boot console earlycon" to happen?
> pass
>
> 	keep_bootcon
>
> as kernel parameter.

And you might want to check if console=ttymxc0 is correct. At least 
some days back while I had a similar issue on i.MX6 it was just a 
wrong console given at the command line.

The boot log you sent has

Serial: IMX driver

but unfortunately doesn't tell us which UART port is used (if there 
are several at all like with i.MX6).

Best regards

Dirk
