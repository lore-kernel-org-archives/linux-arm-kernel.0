From: sdu.liu@huawei.com (Liu hua)
Date: Sat, 22 Mar 2014 13:14:43 +0800
Subject: [PATCH] ARM: kdump: Avoid overflow when converting pfn to physaddr
In-Reply-To: <20140318104855.GU21483@n2100.arm.linux.org.uk>
References: <1395138042-62364-1-git-send-email-sdu.liu@huawei.com>
 <20140318104855.GU21483@n2100.arm.linux.org.uk>
Message-ID: <532D1C43.4070206@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/3/18 18:48, Russell King - ARM Linux wrote:
> On Tue, Mar 18, 2014 at 06:20:42PM +0800, Liu Hua wrote:
>> When we configure CONFIG_LPAE=y, pfn << PAGE_SHIFT will
>> overflow if pfn >= 0x100000 in copy_oldmem_page.
>>
>> So use __pfn_to_phys for converting.
> 
> Yes.  The sad thing is that if you grep the kernel for similar things,
> it's littered with this problem.  I'm not sure whether anyone
> particularly "owns" the crash_dump.c file - Mika Westerberg and
> Olaf Hering were the last two to touch it... I guess put this in my
> patch system please.
> 
> Thanks.
> 

Yes, I found this problem in serval places after a quick review. I will
do a check on this.
