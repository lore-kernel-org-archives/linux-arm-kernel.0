From: pullip.cho@samsung.com (KyongHo Cho)
Date: Fri, 21 Jan 2011 20:15:24 +0900
Subject: [PATCH] ARM: mm: Regarding section when dealing with meminfo
In-Reply-To: <20110121103850.GI13235@n2100.arm.linux.org.uk>
References: <1295516739-9839-1-git-send-email-pullip.cho@samsung.com>
	<1295544047.9039.609.camel@nimitz>
	<20110120180146.GH6335@n2100.arm.linux.org.uk>
	<AANLkTimsL8YfSdXCBpN2cNVpj8HeJF0f-A7MJQoie+Zm@mail.gmail.com>
	<20110121103850.GI13235@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=8DnGVJ6j4rHv+bQoTK2UhgMysC95LuKjH-fBy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011 at 7:38 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jan 21, 2011 at 11:12:27AM +0900, KyongHo Cho wrote:
>> Since the size of section is 256 mib and NR_BANKS is defined as 8,
>> no ARM system can have more RAM than 2GiB in the current implementation.
>> If you want banks in meminfo not to cross sparsemem boundaries,
>> we need to find another way of physical memory specification in the kernel.
>
> There is no problem with increasing NR_BANKS.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
I think it is not reasonable to split a contiguous physical memory
into several chunks.
9 banks are required to use 2 gib.
Even though you think it is no problem,
it becomes a problem when we want to give physical memory information
via booting command line but atag
because there is a restriction in number of characters in booting command line.

I don't understand why larger bank size than the section size is problem.
