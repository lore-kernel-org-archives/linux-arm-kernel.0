From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 9 Jan 2012 12:46:09 +0100
Subject: [PATCH 10/14] mmc: mmci: Cache MMCICLOCK and MMCIPOWER register
In-Reply-To: <20120108102533.GA21765@n2100.arm.linux.org.uk>
References: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
 <1323106560-5218-11-git-send-email-ulf.hansson@stericsson.com>
 <20120108102533.GA21765@n2100.arm.linux.org.uk>
Message-ID: <4F0AD381.9020105@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Mon, Dec 05, 2011 at 06:35:56PM +0100, Ulf Hansson wrote:
>> Instead of reading a register value everytime we need to
>> apply a new value for it, maintain a cached copy for it.
>> This also means we are able to skip writes that are not
>> needed.
> 
> I'm not sure this is a good idea.  The ARM Primecells require a certain
> number of bus clocks and MCLK periods between writes to both these
> registers, and reading them back helps to ensure that we conform to
> that requirement.  Maintaining a cached copy of them allows faster
> writes to these registers which could cause that requirement to be
> violated.

You are definitely right. But how do we know that reading the register 
value is enough?

> 
> What you could do is read the register, modify, and check whether the
> modification has had any effect before writing it back.  That will
> allow unnecessary writes to still be skipped.
> 

That could work. Do you want me to fixup the patch to include this "read 
before write" mechanism then?

BR
Ulf Hansson
