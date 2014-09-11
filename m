From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 11 Sep 2014 13:52:51 +0200
Subject: [PATCH v3 0/8] rtc: at91sam9: add DT support
In-Reply-To: <20140911120659.14daa624@bbrezillon>
References: <1410425767-17874-1-git-send-email-boris.brezillon@free-electrons.com>	<20140911093942.GA12295@localhost>
 <20140911120659.14daa624@bbrezillon>
Message-ID: <54118D13.3010608@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/2014 12:06, Boris BREZILLON :
> On Thu, 11 Sep 2014 11:39:42 +0200
> Johan Hovold <johan@kernel.org> wrote:
> 
>> On Thu, Sep 11, 2014 at 10:55:59AM +0200, Boris BREZILLON wrote:
>>
>>> Johan, let me know if this version addresses part of your concerns.
>>
>> Looks good to me. I just have a few minor comments on two of the patches.
>>
>>> I'm open to any suggestion/rework to address other previously discussed
>>> issues, as long as it does not end up in a dead-end (like the discussion
>>> you had last year):
>>>  - the fact that the RTT block could be used for something that is not
>>>    an RTC
>>>  - the fact that referencing the GPBR node and defining a GPBR register
>>>    number to store RTC time info could be considered as an HW config and
>>>    not an HW description and thus should not be described in the DT
>>
>> No doubt.
> 
> Okay then. Any suggestion to do otherwise ?
> Alexandre suggested to pass the GPBR register number through a module
> parameter, and retrieve the GPBR syscon by searching for a gpbr node
> (or atmel,at91sam9260-gpbr compatible node) in the device tree.
> 
> I'm not a big fan of this solution, as it implies passing driver
> specific config to the global cmdline (and we'll have to handle the
> 9263 case where 2 RTT blocks are availables).

Nope, I don't like messing with the cmdline for something like that.

atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
is perfectly fine for me.

Bye,
-- 
Nicolas Ferre
