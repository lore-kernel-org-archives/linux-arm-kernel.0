From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Mar 2010 09:11:32 +0100
Subject: Query about Float Point Operation
In-Reply-To: <d82162471003282222q5e463306rd385c3ed54879e4d@mail.gmail.com>
References: <tencent_1612D48D0AEC89DB53D9FFBB@qq.com>
	<d82162471003282222q5e463306rd385c3ed54879e4d@mail.gmail.com>
Message-ID: <20100329081132.GA9988@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 29, 2010 at 10:52:50AM +0530, Rajanikanth H.V wrote:
> 2010/3/23 ??? <914059751@qq.com>:
> > Hi , guys
> > I want to do float point operations in kernel like the following,
> >
> > int foo(double d)
> > {
> >
> > return (int)d*d;
> >
> > }
> >
> > while compiling output error msg like following:
> > cannt find eabi_dmul ?balabla??????
> >
> > May I ask any possibility of use float point operation in the kernel space?
> > Any hints/doc would be appreciated!
> I do not know how are you compiling the required function.
> Use hardware floating point support. If your target SOC support.

And if you do this, you end up corrupting the FP state for user
applications.  Then you will complain when your user applications
don't work as you expect.
