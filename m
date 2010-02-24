From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 24 Feb 2010 10:52:47 +0800
Subject: QUERY: Inclusion of header files in kernel header files.
In-Reply-To: <22dbbef21002222230x780c1ffatca5541453f6043ab@mail.gmail.com>
References: <22dbbef21002222230x780c1ffatca5541453f6043ab@mail.gmail.com>
Message-ID: <f17812d71002231852l1e47add7pc17764c67d26ae2b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2010 at 2:30 PM, viresh kumar <viresh.linux@gmail.com> wrote:
> Hello,
> I have been through many kernel header files and have found that kernel
> header
> files at many places don't include other header files which they have
> dependency upon.
> For example:
> <linux/amba/bus.h> uses struct device and struct resource and it doesn't
> include <linux/device.h> and <linux/resource.h> header files.
> Now, whenever i try to include bus.h, i have to include device.h and
> resource.h.
> Is this correct approach?
> Again, if i include device.h and resource.h, they must be included before
> bus.h.
> Now this will disturb the alphabetical ordering of including header files
> sometimes. (not in this example)
> Any idea behind this philosophy.
>

My understanding is that if you are going to include every dependency
into the header files, they are going to explode very soon. E.g. like bus.h,
as long as you declared something like:

struct device;
struct resource;

....

The compiler will be happy to know the structures are actually defined
elsewhere when processing the header file itself (as long as there is
no direct de-reference of the field members of these structures). And
thus in .c file you are going to decide all the dependent header files
by your own.

> regards,
> viresh kumar
> ST Microelectronics
> India.
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
