From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Fri, 26 Mar 2010 18:31:50 +0100
Subject: [PATCH] Including device.h and resource.h header files in
	linux/amba/bus.h
In-Reply-To: <1269511413-30621-1-git-send-email-viresh.kumar@st.com>
References: <1269511413-30621-1-git-send-email-viresh.kumar@st.com>
Message-ID: <63386a3d1003261031p63224296pd4b1a649108af00b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/3/25 Viresh KUMAR <viresh.kumar@st.com>:

> linux/amba/bus.h have dependencies on linux/device.h and linux/resource.h, but
> it doesn't include them. We get compilation errors in our files which include
> bus.h but doesn't include device.h and resource.h. This patch includes device.h
> and resource.h in linux/amba/bus.h file.

The customs of the kernel is to not #include .h files into each other so much,
the reason being that this easily goes out of hand. Instead #include
device.h and resource.h into your sourcefile above the amba/bus.h
inclusion.

Yours,
Linus Walleij
