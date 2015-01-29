From: robherring2@gmail.com (Rob Herring)
Date: Thu, 29 Jan 2015 10:30:02 -0600
Subject: [PATCH] dtc: Use quotes to include header files
In-Reply-To: <20150129155646.BBA8AC413BE@trevor.secretlab.ca>
References: <7947240.7yktm8fT2X@wuerfel>
 <1418696004-12829-1-git-send-email-chris.packham@alliedtelesis.co.nz>
 <20150129155646.BBA8AC413BE@trevor.secretlab.ca>
Message-ID: <CAL_JsqJ9P8Wco3szNW0gU-mSV=ryDr6ZfZ3y1XETYuVOX6XYNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 29, 2015 at 9:56 AM, Grant Likely <grant.likely@linaro.org> wrote:
> On Tue, 16 Dec 2014 15:13:24 +1300
> , Chris Packham <chris.packham@alliedtelesis.co.nz>
>  wrote:
>> Currently in arch and driver code that needs early access to the
>> flattened device tree it is necessary to add specific CFLAGS so that
>> when scripts/dtc/libfdt/libfdt.h is included the C preprocessor is able
>> to locate the libfdt versions of libfdt_env.h and fdt.h without
>> generating an error.

[...]

>> diff --git a/scripts/dtc/libfdt/libfdt.h b/scripts/dtc/libfdt/libfdt.h
>> index 73f4975..ea1ddcd 100644
>> --- a/scripts/dtc/libfdt/libfdt.h
>> +++ b/scripts/dtc/libfdt/libfdt.h
>> @@ -51,8 +51,8 @@
>>   *     EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>>   */
>>
>> -#include <libfdt_env.h>
>> -#include <fdt.h>
>> +#include "libfdt_env.h"
>> +#include "fdt.h"
>
> Until this is resolved with upstream DTC, what about adding dummy
> libfdt.h, libfdt_env.h and fdt.h to include/linux? That would get this
> out of the blocker path for merging this code.

2 of those already exist. Is it only a matter of adding fdt.h or is
there more to it?

This could also be carried as part of the import script to fix up.

Rob
