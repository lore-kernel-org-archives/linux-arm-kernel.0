From: tj@kernel.org (Tejun Heo)
Date: Tue, 05 Jan 2010 08:03:50 +0900
Subject: [PATCH] stack2core: show stack message and convert it to core
	file when kernel die
In-Reply-To: <daef60381001040822q188d7374te5a177c5f9877ac2@mail.gmail.com>
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com>
	<4B411F14.1040302@kernel.org>
	<20100103150134.5bdab023@infradead.org>
	<4B412341.2010002@kernel.org>
	<20100103151406.20228c3a@infradead.org>
	<daef60381001040822q188d7374te5a177c5f9877ac2@mail.gmail.com>
Message-ID: <4B4273D6.2010306@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 01/05/2010 01:22 AM, Hui Zhu wrote:
> For the s2c, user just "s2c < message >core" It did everything with itself.
> After that, gdb vmlinux core.

It is true that by making the kernel oops message more verbose, s2c
can be made way simpler.  However, dependence on standard object tools
or perl is already assumed and avoiding it doesn't really buy
anything.  I really like the idea but unfortunately I'm doubtful that
it will be able to go upstream in the current form.  The suggested
solution (extending markup_oops.pl) won't be too much work, most of
functionality will remain the same and will have much higher chance of
getting included.

Thanks.

-- 
tejun
