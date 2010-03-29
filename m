From: 914059751@qq.com (rocky)
Date: Mon, 29 Mar 2010 16:19:44 +0800
Subject: =?gb2312?B?tPC4tDogUXVlcnkgYWJvdXQgRmxvYXQgUG9pbnQgT3BlcmF0aW9u?=
In-Reply-To: <d82162471003282222q5e463306rd385c3ed54879e4d@mail.gmail.com>
References: <tencent_1612D48D0AEC89DB53D9FFBB@qq.com>
	<d82162471003282222q5e463306rd385c3ed54879e4d@mail.gmail.com>
Message-ID: <1420D1D89B5845EABCFDDB44782A0A1B@dufan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks you guys??

Read the code in arch/arm/nwfpe/ and arch/arm/vfp, kernel DOES provide float
point operation ONLY for user space in terms of two aspects.
1:
Employ hardware float point instructions, easy to implement, while increase
die size of whole chip.
2:
Using software to emulate above hardware float point instructions, in short,
decode every undefined instruction exceptions to inspect if that's an
emulated float point instructs. While in this way kernel burden will
increase as there are too many exceptions to be handled.

So basically, no float point operation in kernel space.

ROCKY
B.R

-----????-----
???: Rajanikanth H.V [mailto:rkiyerpersonal at gmail.com] 
????: 2010?3?29? 13:23
???: ???
??: linux-arm-kernel
??: Re: Query about Float Point Operation

2010/3/23 ??? <914059751@qq.com>:
> Hi , guys
> I want to do float point operations in kernel like the following,
>
> int foo(double d)
> {
>
> return (int)d*d;
>
> }
>
> while compiling output error msg like following:
> cannt find eabi_dmul ?balabla??????
>
> May I ask any possibility of use float point operation in the kernel
space?
> Any hints/doc would be appreciated!
I do not know how are you compiling the required function.
Use hardware floating point support. If your target SOC support.
Also verify whether Floating Point Emulation -> VFP is enabled in your
config.

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
