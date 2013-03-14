From: smoch@web.de (Soeren Moch)
Date: Thu, 14 Mar 2013 21:51:11 +0100
Subject: [PATCH] USB: EHCI: fix for leaking isochronous data
In-Reply-To: <Pine.LNX.4.44L0.1303141630550.1194-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1303141630550.1194-100000@iolanthe.rowland.org>
Message-ID: <5142383F.6010001@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.03.2013 21:32, Alan Stern wrote:
> On Thu, 14 Mar 2013, Soeren Moch wrote:
>
>>>> I added a debug message to
>>>> drivers/usb/host/ehci-sched.c:itd_urb_transaction() to log the
>>>> allocation flags, see log below.
>>>
>>> But it looks like you didn't add a message to end_free_itds(), so we
>>> don't know when the memory gets deallocated.  And you didn't print out
>>> the values of urb, num_itds, and i, or the value of itd (so we can
>>> match up allocations against deallocations).
>>
>> OK, I will implement this more detailed logging. But with several
>> allocations per second and runtime of several hours this will result in
>> a very long logfile.
>
> If the memory really is being leaked here in some sort of systematic
> way, we may be able to see it in your debugging output after a few
> seconds.
>

OK, here are the first seconds of the log. But the buffer exhaustion 
usually occurs after several hours of runtime...

  Soeren Moch

-------------- next part --------------
A non-text attachment was scrubbed...
Name: syslog.gz
Type: application/x-gzip
Size: 24383 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130314/e5ab1a24/attachment-0001.bin>
