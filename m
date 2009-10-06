From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 6 Oct 2009 14:12:21 +0100
Subject: ARM1176 register writes are in reverse?
In-Reply-To: <b9e8fcbd0910060510y3dd9ea36x6c97db47f0dfc886@mail.gmail.com>
References: <b9e8fcbd0910060510y3dd9ea36x6c97db47f0dfc886@mail.gmail.com>
Message-ID: <20091006131221.GO31920@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2009 at 05:40:36PM +0530, Nicholas Van Orton wrote:
> Hi,
> 
> I noticed that register writes to ARM1176 need to be in the reverse
> order. That is, lets say I need to write 0xABCD to a register. But in
> the actual write using __raw_writel() the value needs to be changed to
> 0xCDAB. Why is this so? The Davinci or OMAP on the other hand for
> example, which is an ARM 926 does not need any such manipulation. Why
> is the ARM1176 an exception?

No, works fine for all the Samsung ARM11 chips. Sounds like either you're
running the core big-endian, or part of your bus is big-endian?

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
