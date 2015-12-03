From: bjorn@kryo.se (Bjorn Andersson)
Date: Thu, 3 Dec 2015 13:22:50 -0800
Subject: [RESEND v4 2/6] remoteproc: debugfs: Add ability to boot remote
 processor using debugfs
In-Reply-To: <2473673.tSymyNlg3h@wuerfel>
References: <1448370862-19120-1-git-send-email-lee.jones@linaro.org>
 <2600153.9u9Z7N2IT1@wuerfel> <20151203172830.GB26902@x1>
 <2473673.tSymyNlg3h@wuerfel>
Message-ID: <CAJAp7OgF_2MNyuK9aKi9BRpq9B918MKijrjByDeZ_iZZbkR7iw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 3, 2015 at 1:12 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 03 December 2015 17:28:30 Lee Jones wrote:
>> >
>> > Ah, interesting. I haven't tried myself, and just tried to read the
>> > code. Maybe glibc already catches zero-length writes before it gets
>> > into the kernel, or I just missed the part of the syscall that checks
>> > for this.
>>
>> Glibc is responsible indeed:
>>
>>   http://osxr.org/glibc/source/io/write.c
>
> Ok, so an attacker can force the stack overflow by calling
> syscall(__NR_write, fd, p, 0) if that has any potential value,
> but normal users won't hit this case.
>

It seems glibc might be the only libc implementation with this protection.

Regards,
Bjorn
