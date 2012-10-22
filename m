From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Mon, 22 Oct 2012 10:39:54 +0530
Subject: 3.7-rc-1 Release Causing application failure for compilation
In-Reply-To: <20121018183930.GA4048@tarshish>
References: <CA+V-a8uj4wSz60Ov8S3MpSrUe-D5+OcpVsFjURzSEcE6VdvGGQ@mail.gmail.com>
 <20121018183930.GA4048@tarshish>
Message-ID: <CA+V-a8vLH9z=ZY-TPn8V2zCGtKgNvLKvHyKKwofM2FQ190oPMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

On Fri, Oct 19, 2012 at 12:09 AM, Baruch Siach <baruch@tkos.co.il> wrote:
> Hello Prabhakar Lad,
>
> On Thu, Oct 18, 2012 at 09:49:34PM +0530, Prabhakar Lad wrote:
>> I have updated to 3.7-rc1 kernel version with latest head with
>> commit-id 43c422eda99b894f18d1cca17bcd2401efaf7bd0
>> but when I try to cross compile the Application I am getting following errors.
>>
>> /home/plad/ti/linus/linus/include/linux/types.h:14:26: error:
>> conflicting types for 'fd_set'
>> /home/plad/CodeSourcery/Sourcery_G++_Lite/bin/../arm-none-linux-gnueabi/libc/usr/include/sys/select.h:78:5:
>> note: previous declaration of 'fd_set' was here
>> /home/plad/ti/linus/linus/include/linux/types.h:15:25: error:
>
> [snip]
>
>> I use the codesourcery toolchain for cross compiling the applications
>> for ARM. The same compiler is used to  build the uImage for ARM, but
>> when I try building the apps I see this issue. Can any help me out in
>> fixing this.
>
> It seems that you are including kernel headers directly in your userspace
> code. Don't do that. Types defined in kernel headers conflict with types
> defined in your toolchain's kernel headers. Instead, just use the headers that
> are part of your toolchain, which in turn include kernel headers that your
> toolchain was built with.
>
Thanks for the reply, got it fixed :)

Regards,
--Prabhakar Lad

> baruch
>
> --
>      http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
