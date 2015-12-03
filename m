From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Dec 2015 22:12:59 +0100
Subject: [RESEND v4 2/6] remoteproc: debugfs: Add ability to boot remote
 processor using debugfs
In-Reply-To: <20151203172830.GB26902@x1>
References: <1448370862-19120-1-git-send-email-lee.jones@linaro.org>
 <2600153.9u9Z7N2IT1@wuerfel> <20151203172830.GB26902@x1>
Message-ID: <2473673.tSymyNlg3h@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 December 2015 17:28:30 Lee Jones wrote:
> > 
> > Ah, interesting. I haven't tried myself, and just tried to read the
> > code. Maybe glibc already catches zero-length writes before it gets
> > into the kernel, or I just missed the part of the syscall that checks
> > for this.
> 
> Glibc is responsible indeed:
>   
>   http://osxr.org/glibc/source/io/write.c

Ok, so an attacker can force the stack overflow by calling
syscall(__NR_write, fd, p, 0) if that has any potential value,
but normal users won't hit this case.

	Arnd
