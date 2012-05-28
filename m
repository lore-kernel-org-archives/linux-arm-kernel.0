From: stigge@antcom.de (Roland Stigge)
Date: Mon, 28 May 2012 20:17:58 +0200
Subject: [PATCH] serial/of-serial: Add 16654 chip to compatible string list
In-Reply-To: <20120528180139.GC28290@n2100.arm.linux.org.uk>
References: <1338199134-23885-1-git-send-email-stigge@antcom.de>
 <20120528100338.GI24149@n2100.arm.linux.org.uk> <4FC35F97.2030400@antcom.de>
 <20120528150311.GA28290@n2100.arm.linux.org.uk> <4FC3A768.3060208@antcom.de>
 <20120528163151.GB28290@n2100.arm.linux.org.uk> <4FC3BA89.4060804@antcom.de>
 <20120528180139.GC28290@n2100.arm.linux.org.uk>
Message-ID: <4FC3C156.5040609@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/05/12 20:01, Russell King - ARM Linux wrote:
>> Now, introducing a new type, can I add to 8250.c's uart_config[] by
>> introducing a new type (no. 22) after PORT_XR17D15X? Unfortunately,
>> there are the "ARM specific type numbers" after current PORT_MAX_8250
>> (21), but those are not listed in 8250.c's uart_config[]. Or how am I
>> supposed to add a new type?
> 
> If it's 8250, stick it in with the group, otherwise the array will
> become stupidly large.  That's why there's a separation of the two.

Do you mean adding one element to uart_config[] and increasing
PORT_MAX_8250 (actually, the size of uart_config[]) by one? I would also
need to increase the indices of all the following "ARM specific type
numbers" by one (the second group).

Or did I get sth. wrong here?

Thanks in advance,

Roland
