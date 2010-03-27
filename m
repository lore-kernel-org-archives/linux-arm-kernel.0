From: viresh.linux@gmail.com (viresh kumar)
Date: Sat, 27 Mar 2010 17:25:49 +0530
Subject: [PATCH] Including device.h and resource.h header files in
	linux/amba/bus.h
In-Reply-To: <63386a3d1003270213t6939202dof4265d9c8372407a@mail.gmail.com>
References: <1269511413-30621-1-git-send-email-viresh.kumar@st.com>
	<63386a3d1003261031p63224296pd4b1a649108af00b@mail.gmail.com>
	<22dbbef21003262207i3fa10157jf3b8577b307ce99d@mail.gmail.com>
	<63386a3d1003270213t6939202dof4265d9c8372407a@mail.gmail.com>
Message-ID: <22dbbef21003270455i1e7175cbxbbd2e2112931c192@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 27, 2010 at 2:43 PM, Linus Walleij
<linus.ml.walleij@gmail.com> wrote:
> 2010/3/27 viresh kumar <viresh.linux@gmail.com>:
>
>> Some time back i have initiated a thread regarding this type of issues. You can
>> find them here:
>>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-February/010258.html
>>
>> And my understanding after the discussion was:
>>
>> It is the responsibility of a header files, using types definitions
>> from outside world,
>> to include all header files required for proper compilation.
>> This is not the responsibility of the user using this file to add
>> dependency header in
>> his source files.
>
> On the other hand Documentation/SubmitChecklist contains this:
>
> 1: If you use a facility then #include the file that defines/declares
> ? that facility. ?Don't depend on other header files pulling in ones
> ? that you use.

I agree on the above statement.

But what if i don't want to use every type that is used in header file
i am including. For ex: I don't want to use resource
structure in my code and i need to include bus.h for some
other definition. Then why should i get a compilation warning.

Again, according to above statement from submitchecklist:
shouldn't bus.h include device.h and resource.h, as it is using
these facilities.

regards,
viresh kumar.
