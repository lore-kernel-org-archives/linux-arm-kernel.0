From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 9 Aug 2012 15:10:40 +0800
Subject: [Openpxa-users] pxa3x0 smart panel interface
In-Reply-To: <201208082157.22064.marek.vasut@gmail.com>
References: <20120806152551.4ec2cad0@laptoppieter>
 <201208082157.22064.marek.vasut@gmail.com>
Message-ID: <CAN1soZyf5m+n7F+=jiKhqCjEuxdzESq9Cft8oDUhD3t4UN75sA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 3:57 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Dear pieterg,
>
> CCing linux-arm-kernel and Haojian
>
>> Hi all,
>>
>> Does any of you have experience with interfacing smart lcd panels, with
>> a pxa3x0?
>>

We didn't try to connect smart lcd panel with pxa300 or pxa310.

>> I'm interfacing an ILI9327DS smart panel controller, all commands
>> are handled correctly, however the SMART_CMD_WRITE_FRAME command (which
>> sends out all frame data) seems to produce an invalid number of output
>> bytes every now and then.
>> This results in a shifted display, every 10-100 updates (immediately
>> corrected by the next update)

Do you mean that you observe this behavior on oscilloscope? Are you
using LCD interface
or SMEM interface?

>>
>> The strange thing is that this does not occur with a pxa300, but it
>> occurs with the pxa310 and pxa320.
>> However running the 310/320 with the same ACCR as I'm running the 300
>> does not 'fix' it.

Do you change frequency while you are testing this smart panel?

>> And I'm not sure it is even timing related, I've tried to configure
>> huge smart timing delay parameters, but the results remain the same.
>> (in fact I can even lower the parameters to way under the
>> controller specs, and the issue does not get worse).
>> I've also played with the drive strength of the LCD lines, which also
>> does not have an effect on the issue.
>>
>> I do not think this is a controller bug, because before this ILI9327DS
>> controller, we had a display with a different controller chip, with
>> which I experienced the same thing, however at that time even with the
>> pxa300.
>> We switched to the ILI9327DS (for a different reason), and I was glad to
>> find that it worked fine with the pxa300.
>> Till I discovered it had the same issues, but then only with a
>> pxa310/320.
LCD controller between pxa300 and pxa310 is nearly same.
