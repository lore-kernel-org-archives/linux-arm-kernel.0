From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 24 Jul 2017 18:38:23 +0100
Subject: [PATCH 1/8] mailbox: introduce ARM SMC based mailbox
In-Reply-To: <CABb+yY2hjfXdiCSZXd5TJf8=janwjWEo2oSqrxdoWc=1oUtteQ@mail.gmail.com>
References: <20170630095608.24943-1-andre.przywara@arm.com>
 <20170630095608.24943-2-andre.przywara@arm.com>
 <CABb+yY18Aye3wr2A9-+jemqc=VSRyUA+xzKGo9s0G4KCt1ovyA@mail.gmail.com>
 <22d23c1d-ea8d-9829-4624-6305cd83ad4a@arm.com>
 <CABb+yY2hjfXdiCSZXd5TJf8=janwjWEo2oSqrxdoWc=1oUtteQ@mail.gmail.com>
Message-ID: <0aaba7fb-2183-2d4d-ba04-64b30cd0ae10@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/07/17 18:20, Jassi Brar wrote:
> On Mon, Jul 24, 2017 at 4:50 AM, Andr? Przywara <andre.przywara@arm.com> wrote:
>> On 02/07/17 06:55, Jassi Brar wrote:
>>
>>>> +       mbox_chan_received_data(link, (void *)res.a0);
>>>> +
>>> Or you can update the 'data' with value from 'a0' ?
>>
>> Mmh, I am a bit puzzled by this. Why would this be needed or useful?
>>
> I meant instead of calling mbox_chan_received_data(), simply update
> the value at 'data' with res.a0
> 
> Technically the firmware does not "send" us a message. It only updates
> the structure we share with it. So maybe we could reflect that by
> updating the data pointer the client driver asked to send.
> Also it is optional for clients to provide the rx_callback(). By
> calling mbox_chan_received_data() you mandate clients provide that
> callback.
> 
> Nothing serious, just that looking closely, updating 'data' seems a
> better option.
> 
>> I see that the SCPI firmware driver (as the user of the mailbox API) is
>> expecting the return value from a0 as returned above, translating the
>> firmware error codes into Linux' ones.
>>
> I am afraid, SCPI driver is not the golden example for client drivers
> to follow. It is supposed to work only with MHU, and then, it is
> likely to break if some other protocol is running parallel to it.
> 

Not sure why do you say it works only with ARM MHU ? AmLogic uses it
with their mailbox driver. However they followed an interim version of
the SCPI spec which is termed "legacy" in the driver.
-- 
Regards,
Sudeep
