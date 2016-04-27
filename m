From: felipe.balbi@linux.intel.com (Felipe Balbi)
Date: Wed, 27 Apr 2016 10:19:32 +0300
Subject: [RESEND PATCH v2 5/7] usb: xhci: plat: Remove checks for optional
 clock in error/remove path
In-Reply-To: <20160427143343.6510ff57@xhacker>
References: <1461675460-2295-1-git-send-email-jszhang@marvell.com>
 <1461675460-2295-6-git-send-email-jszhang@marvell.com>
 <87h9enpqdb.fsf@intel.com> <20160427143343.6510ff57@xhacker>
Message-ID: <877ffjo6wr.fsf@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Jisheng Zhang <jszhang@marvell.com> writes:
> Dear Felipe,
>
> On Wed, 27 Apr 2016 08:33:52 +0300 Felipe Balbi wrote:
>
>> Jisheng Zhang <jszhang@marvell.com> writes:
>> > Commit 63589e92c2d9 ("clk: Ignore error and NULL pointers passed to
>> > clk_{unprepare, disable}()") allows NULL or error pointer to be passed
>> > unconditionally.
>> >
>> > This patch is to simplify probe error and remove code paths.  
>> 
>> this seems wrong to me. xhci->clk isn't initialized to NULL, it's either
>> initialized to a valid struct clk * or some ERR_PTR() value.
>
> Commit 63589e92c2d9 could also ignore error value ;)

oh okay, thanks for that. That's, IMHO, quite dangerous ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160427/c7a01efe/attachment.sig>
