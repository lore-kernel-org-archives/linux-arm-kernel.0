From: viresh.linux@gmail.com (viresh kumar)
Date: Sat, 27 Mar 2010 10:37:19 +0530
Subject: [PATCH] Including device.h and resource.h header files in
	linux/amba/bus.h
In-Reply-To: <63386a3d1003261031p63224296pd4b1a649108af00b@mail.gmail.com>
References: <1269511413-30621-1-git-send-email-viresh.kumar@st.com>
	<63386a3d1003261031p63224296pd4b1a649108af00b@mail.gmail.com>
Message-ID: <22dbbef21003262207i3fa10157jf3b8577b307ce99d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 26, 2010 at 11:01 PM, Linus Walleij
<linus.ml.walleij@gmail.com> wrote:
> 2010/3/25 Viresh KUMAR <viresh.kumar@st.com>:
>
>> linux/amba/bus.h have dependencies on linux/device.h and linux/resource.h, but
>> it doesn't include them. We get compilation errors in our files which include
>> bus.h but doesn't include device.h and resource.h. This patch includes device.h
>> and resource.h in linux/amba/bus.h file.
>
> The customs of the kernel is to not #include .h files into each other so much,
> the reason being that this easily goes out of hand. Instead #include
> device.h and resource.h into your sourcefile above the amba/bus.h
> inclusion.
>

Some time back i have initiated a thread regarding this type of issues. You can
find them here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-February/010258.html

And my understanding after the discussion was:

It is the responsibility of a header files, using types definitions
from outside world,
to include all header files required for proper compilation.
This is not the responsibility of the user using this file to add
dependency header in
his source files.

Ex: As everybody who is going to use bus.h has to have device.h and
resource.h included.
So why not have all of them included once only. So that people don't
see compilation
warnings when they try to use these header files. And don't have to
add them in all source
files using them.

What do you say?

regards,
viresh kumar.
