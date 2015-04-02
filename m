From: harinikatakamlinux@gmail.com (Harini Katakam)
Date: Fri, 3 Apr 2015 01:39:52 +0530
Subject: [PATCH] i2c: cadence: Handling Slave monitor mode
In-Reply-To: <20150327153713.GC27238@katana>
References: <BL2FFO11FD05378650E02EA6549B4DF50E8030@BL2FFO11FD053.protection.gbl>
 <20150327153713.GC27238@katana>
Message-ID: <CAFcVECKaLBvOVvTca87-oTue5nF_pek_0msFZDD8y4yuCHW2EA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Fri, Mar 27, 2015 at 9:07 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Tue, Mar 17, 2015 at 09:48:15PM +0530, Nava kishore Manne wrote:
>> In slave monitor mode, the I2C interface is set up as a master and
>> continues to attempt a transfer to a particular slave until the
>> slave device responds with an ACK.
>>
>> Added this feature for zero length transfers enable the controller
>> for slave monitor interrupt and get the status. Disable the slave
>> monitor mode feature upon successful handling.
>>
>> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
>> Acked-by: Harini Katakam <harinik@xilinx.com>
>
> I am not sure this is going to work.
>
> How often is this access tried when there is no device? It should be
> tried only once.

Once slave monitor is enabled in the host controller, it retries till there's an
ACK or slave monitor is disabled. The SW wont be involved and need not
be interrupted in this gap. The way this feature works in the controller though,
I'm afraid there's no way to distinguish between no slave/ busy slave.
The out is the software timeout in that case.
Please suggest how to use this feature better.

>
> Those 0byte messages can be read or write, so transferring one bit, one
> could say. I assume this one can only read? (which is not a show-stopper
> but the cases should be handled)
>

Yes, only read is used.

Thanks for the review.

Regards,
Harini
