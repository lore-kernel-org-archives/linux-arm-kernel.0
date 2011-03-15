From: ratbert.chuang@gmail.com (Po-Yu Chuang)
Date: Tue, 15 Mar 2011 11:07:58 +0800
Subject: [PATCH] arm: cmpxchg syscall should data abort if page not write
	or not young
In-Reply-To: <20110314104038.GB26085@n2100.arm.linux.org.uk>
References: <1300098516-1601-1-git-send-email-ratbert.chuang@gmail.com>
	<20110314104038.GB26085@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinekDMZUJSyOqOuPPpuoq49wFTzc1ESGqEdezzs@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell King,

On Mon, Mar 14, 2011 at 6:40 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Mar 14, 2011 at 06:28:36PM +0800, Po-Yu Chuang wrote:
>> From: Po-Yu Chuang <ratbert@faraday-tech.com>
>>
>> If the page to cmpxchg is user mode read only (not write)
>> or invalid (not young), we should simulate a data abort first.
>
> No. ?If it is not young then it should be made young. ?Age is an effect
> of accesses. ?It's not a permission.

OK, I will rethink about the not young part.
Thanks for your pointer.

I will resubmit a v2 which contains only the read only check.
It fixes a problem we met with futex.

best regards,
Po-Yu Chuang
