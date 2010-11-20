From: bill_carson@126.com (rocky)
Date: Sat, 20 Nov 2010 12:17:02 +0800 (CST)
Subject: Query about cplusplus in linkage.h
Message-ID: <13701df.df91.12c677fe0fd.Coremail.bill_carson@126.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, all

I am a little confused about the following definition :

--------------include/linux/linkage.h-----------
#ifdef __cplusplus
#define CPP_ASMLINKAGE extern "C"
#else
#define CPP_ASMLINKAGE
#endif

#ifndef asmlinkage
#define asmlinkage CPP_ASMLINKAGE
#endif

all system call functions are marked with asmlinkage, as well as other kernel function like printk/schedule/do_softirq


so every asmlinkage function has extern "C"  attribute if cplusplus is defined, which definitely happens  when compiling C++ code.

I dont get it when cplusplus is needed when compiling kernel?

Can anyone help me out of this little misunderstanding?

Thansk




		
