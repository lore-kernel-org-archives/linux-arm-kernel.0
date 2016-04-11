From: felipe.balbi@linux.intel.com (Felipe Balbi)
Date: Mon, 11 Apr 2016 11:24:22 +0300
Subject: [PATCH] usb: core: buffer: avoid NULL pointer dereferrence
In-Reply-To: <1460358968.10419.26.camel@mhfsdcap03>
References: <1460106483-24793-1-git-send-email-chunfeng.yun@mediatek.com>
 <20160408140701.GA3547@kroah.com> <1460343705.10419.12.camel@mhfsdcap03>
 <87shyspwbz.fsf@intel.com> <1460358968.10419.26.camel@mhfsdcap03>
Message-ID: <87y48ko8nd.fsf@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

chunfeng yun <chunfeng.yun@mediatek.com> writes:
>> > On Fri, 2016-04-08 at 07:07 -0700, Greg Kroah-Hartman wrote:
>> >> On Fri, Apr 08, 2016 at 05:08:03PM +0800, Chunfeng Yun wrote:
>> >> > NULL pointer dereferrence will happen when class driver
>> >> > wants to allocate zero length buffer and pool_max[0]
>> >> > can't be used, so skip reserved pool in this case.
>> >> 
>> >> Why would a driver want to allocate a 0 length buffer?  What driver does
>> >> this?
>> > It's misc/usbtest.c
>> 
>> that'll do what you ask it to do with the userspace tool testusb. Are
>> you trying to pass a size of 0 ?
>> 
> No, I just ran "testusb -t10" which called test_ctrl_queue().
> In this function, sub-case 8 passed a parameter @len as 0 to
> simple_alloc_urb(), and then it tried to allocate a 0-length buffer.

odd, I have never seen this problem running testusb with the same
arguments.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160411/abb676eb/attachment.sig>
