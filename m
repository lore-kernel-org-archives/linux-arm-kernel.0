From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 29 Mar 2010 12:23:17 -0500
Subject: [PATCH] Including device.h and resource.h header files in
	linux/amba/bus.h
In-Reply-To: <20100329171947.GC28468@n2100.arm.linux.org.uk>
References: <1269511413-30621-1-git-send-email-viresh.kumar@st.com>
	<63386a3d1003261031p63224296pd4b1a649108af00b@mail.gmail.com>
	<22dbbef21003262207i3fa10157jf3b8577b307ce99d@mail.gmail.com>
	<63386a3d1003270213t6939202dof4265d9c8372407a@mail.gmail.com>
	<22dbbef21003270455i1e7175cbxbbd2e2112931c192@mail.gmail.com>
	<63386a3d1003271357i7cb5aa84w35a447ed34db8d72@mail.gmail.com>
	<0D753D10438DA54287A00B027084269763690EBC7F@AUSP01VMBX24.collaborationhost.net>
	<20100329171947.GC28468@n2100.arm.linux.org.uk>
Message-ID: <0D753D10438DA54287A00B027084269763690EBCB2@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, March 29, 2010 10:20 AM, Russell King wrote:
> On Mon, Mar 29, 2010 at 12:16:32PM -0500, H Hartley Sweeten wrote:
>> On Saturday, March 27, 2010 1:57 PM, Linus Walleij wrote:
>>>> On Sat, Mar 27, 2010 at 2:43 PM, Linus Walleij
>>>>> On the other hand Documentation/SubmitChecklist contains this:
>>>>>
>>>>> 1: If you use a facility then #include the file that defines/declares
>>>>> ? that facility. ?Don't depend on other header files pulling in ones
>>>>> ? that you use.
>>>>
>>>> I agree on the above statement.
>>>>
>>>>(...)
>>>> Again, according to above statement from submitchecklist:
>>>> shouldn't bus.h include device.h and resource.h, as it is using
>>>> these facilities.
>>>
>>> Yes I think you're right, looks like it should be applied then!
>>> Acked-by:
>> 
>> A cleaner solution would be to just add:
>> 
>> struct device;
>> struct resource;
>
> No - it needs the definitions themselves because it otherwise doesn't
> know how to lay out struct amba_device.
>
> What you suggest works fine for pointers, but not if the actual definition
> itself is required.

Oops my bad... I didn't notice that the variables were not pointers.

You are correct, the headers are needed to get the proper definitions.

Regards,
Hartley
