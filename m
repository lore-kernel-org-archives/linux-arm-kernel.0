From: robherring2@gmail.com (Rob Herring)
Date: Tue, 30 Nov 2010 10:24:11 -0600
Subject: [PATCH][ ARM cpu hotplug 1/2 ] extract common code for arm cpu
	hotplug
In-Reply-To: <20101130110331.GA31054@n2100.arm.linux.org.uk>
References: <AANLkTi=fJeOUhH0xUJF8qx-fTJ5popE7ZuVxDZXpTH-i@mail.gmail.com>	<AANLkTimz=xv92c6FN4i4c3Xs-t71L4PHv3SQg0jk-x-r@mail.gmail.com>	<20101129104149.GA10703@n2100.arm.linux.org.uk>	<AANLkTikHv+Rz7+bZY8Qo2drUQO4fjhJgqORcGFB7B6s7@mail.gmail.com>	<20101129192407.GA20761@n2100.arm.linux.org.uk>	<AANLkTimZfnmVMDZ2faUPpDHHv3oAhM9ZcVEpM0_MyHbq@mail.gmail.com>
	<20101130110331.GA31054@n2100.arm.linux.org.uk>
Message-ID: <4CF5252B.5050109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30/2010 05:03 AM, Russell King - ARM Linux wrote:
> On Tue, Nov 30, 2010 at 04:17:32PM +0530, Amit Kucheria wrote:
>> Since the main aim here is to consolidate as much code here as
>> possible while still allowing platforms to override the defaults,
>> would you have an objection to the introduction of a struct smp_ops
>> that'll allow a platform to override the defaults? This seems to be
>> done on other platforms I've briefly looked at.
>
> I see no point to what is being proposed in this thread.  It's _soo_
> little code that the platforms have to implement that it really is
> not worth the effort.
>
Whether the code can be consolidated or not, the current API does not 
allow a single kernel binary (ignoring the list of other issues). The 
introduction of struct smp_ops would help enable both single kernel and 
default versions of the functions.

Rob
