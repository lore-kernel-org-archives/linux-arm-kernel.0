From: cernekee@gmail.com (Kevin Cernekee)
Date: Wed, 26 Nov 2014 08:07:43 -0800
Subject: [PATCH 9/9] usb: {ohci,ehci}-platform: Use new OF big-endian
 helper function
In-Reply-To: <Pine.LNX.4.44L0.1411261013340.1322-100000@iolanthe.rowland.org>
References: <1416962994-27095-10-git-send-email-cernekee@gmail.com>
 <Pine.LNX.4.44L0.1411261013340.1322-100000@iolanthe.rowland.org>
Message-ID: <CAJiQ=7CuLA2vDpnkDysBU100R0uuUidB_ua3sZdV74vNPjV76w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 7:14 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
>> index 43c1a4e..9505c31 100644
>> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
>> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
>> @@ -12,6 +12,8 @@ Optional properties:
>>   - big-endian-regs : boolean, set this for hcds with big-endian registers
>>   - big-endian-desc : boolean, set this for hcds with big-endian descriptors
>>   - big-endian : boolean, for hcds with big-endian-regs + big-endian-desc
>> + - native-endian : boolean, enables big-endian-regs + big-endian-desc
>> +   iff the kernel was compiled for big endian
>
> Is this really a property of the hardware?  It appears to depend on the
> kernel configuration.  As such, is it appropriate for DT?

Yes, the peripheral registers automatically adjust their endianness to
match the CPU.  So if the CPU is running an LE kernel, the peripheral
needs to be accessed in LE mode; if the CPU is running a BE kernel,
the peripheral needs to be accessed in BE mode.
