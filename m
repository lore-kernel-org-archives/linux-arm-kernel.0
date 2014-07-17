From: peter@hurleysoftware.com (Peter Hurley)
Date: Thu, 17 Jul 2014 11:31:59 -0400
Subject: [PATCH 4/5] tty: serial: 8250 core: add runtime pm
In-Reply-To: <20140716160614.GI1365@saruman.home>
References: <1405521903-5877-1-git-send-email-bigeasy@linutronix.de>
 <1405521903-5877-5-git-send-email-bigeasy@linutronix.de>
 <20140716151604.GG1365@saruman.home> <53C6A050.2050409@linutronix.de>
 <20140716160614.GI1365@saruman.home>
Message-ID: <53C7EC6F.6060902@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2014 12:06 PM, Felipe Balbi wrote:
> On Wed, Jul 16, 2014 at 05:54:56PM +0200, Sebastian Andrzej Siewior wrote:
>> On 07/16/2014 05:16 PM, Felipe Balbi wrote:

>>> I wonder if you should get_sync() on start_tx() and only
>>> put_autosuspend() at stop_tx(). I guess the outcome would be
>>> largely the same, no ?
>>
>> I just opened minicom on ttyS0 and gave a try. start_tx() was invoked
>> each time I pressed a key (sent a character). I haven't seen stop_tx()
>> even after after I closed minicom. I guess stop_tx() is invoked if you
>> switch half-duplex communication.
>
> that's bad, I expected stop to be called also after each character.

The 8250 core auto-stops tx when the tx ring buffer is empty (except
in the case of dma, where stopping tx isn't necessary).

Regards,
Peter Hurley
