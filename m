From: jiada_wang@mentor.com (jiwang)
Date: Mon, 13 Apr 2015 15:52:01 +0900
Subject: [PATCH] serial: imx: protect Soft Reset of port with lock
In-Reply-To: <20150326220113.GA24630@kroah.com>
References: <1426228691-20529-1-git-send-email-jiada_wang@mentor.com>
 <20150326220113.GA24630@kroah.com>
Message-ID: <552B6791.60905@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg

On 03/27/2015 07:01 AM, Greg KH wrote:
> On Fri, Mar 13, 2015 at 03:38:11PM +0900, Jiada Wang wrote:
>> Previously Soft Reset (clear of SRST bit in UCR2 register)
>> of UART in startup is not protected by lock, which may have race
>> with console_write, as console_write may occur at anytime even
>> when UART port is shutdown.
>>
>> To avoid this race, protect Soft reset of UART port with spin_lock.
>>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
>>   drivers/tty/serial/imx.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
> Doesn't apply to my tree :(
Can you tell me which tree are you using?
so that I can submit another patch based same tree.

Thanks,
Jiada
