From: teawater@gmail.com (Hui Zhu)
Date: Wed, 6 Jan 2010 15:07:18 +0800
Subject: [PATCH] stack2core: show stack message and convert it to core
	file when kernel die
In-Reply-To: <4B430457.5020906@kernel.org>
References: <daef60381001030705r93b3fbfkc50e7b9bbc62b334@mail.gmail.com>
	<4B411F14.1040302@kernel.org> <20100103150134.5bdab023@infradead.org>
	<4B412341.2010002@kernel.org> <20100103151406.20228c3a@infradead.org>
	<daef60381001040822q188d7374te5a177c5f9877ac2@mail.gmail.com>
	<4B4273D6.2010306@kernel.org>
	<daef60381001050104u5d4adf11k16bec2406501fbd2@mail.gmail.com>
	<4B430457.5020906@kernel.org>
Message-ID: <daef60381001052307x3244442che26075e4a3e0d2f8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 5, 2010 at 17:20, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On 01/05/2010 06:04 PM, Hui Zhu wrote:
>> I agree with read the current stack message is better.
>>
>> About the extending, I have some question with it:
>> 1. ?markup_oops.pl have itself idea, it try use dmesg| markup_oops.pl
>> show what happen to usr. ?This is different with s2c.
>> I am not sure people like it have other function with it. ?Too much
>> part of this file need to be change. ?It need rewrite, just the oops
>> message parse part can be keep.
>
> Yeah, I think you'll need to refactor it and share only the parsing
> frontend. ?Just adding a switch (-m or whatever) which puts it into
> machine-friendly translator mode should do the trick.
>
>> 2. ?I use perl to work in a long time before, I know it good at parse
>> the text, but I am not sure it good at handle struct like:
>
> You don't need to handle the data structure at all. ?Just make it
> parse the dmesg and output machine-friendly formatted output which can
> be processed by s2c. ?ie. just make it do the reformatting.

This idea is very cool.  I will do it.  Thanks for help.  :)

Best regards,
Hui
