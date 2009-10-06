From: turanammo@gmail.com (Nicholas Van Orton)
Date: Tue, 6 Oct 2009 18:58:55 +0530
Subject: ARM1176 register writes are in reverse?
In-Reply-To: <20091006131221.GO31920@trinity.fluff.org>
References: <b9e8fcbd0910060510y3dd9ea36x6c97db47f0dfc886@mail.gmail.com>
	<20091006131221.GO31920@trinity.fluff.org>
Message-ID: <b9e8fcbd0910060628x32aec11crfbfef4d7a5521e80@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 6, 2009 at 6:42 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Tue, Oct 06, 2009 at 05:40:36PM +0530, Nicholas Van Orton wrote:
>> Hi,
>>
>> I noticed that register writes to ARM1176 need to be in the reverse
>> order. That is, lets say I need to write 0xABCD to a register. But in
>> the actual write using __raw_writel() the value needs to be changed to
>> 0xCDAB. Why is this so? The Davinci or OMAP on the other hand for
>> example, which is an ARM 926 does not need any such manipulation. Why
>> is the ARM1176 an exception?
>
> No, works fine for all the Samsung ARM11 chips. Sounds like either you're
> running the core big-endian, or part of your bus is big-endian?
>

Thank you for the mail. Yes, that was the case. I had set the ARM core
to bigendian (and forgot about it), works as expected when that code
was removed. So this was really much ado about nothing. Sorry for the
trouble :-(

Regards,
Nicholas
