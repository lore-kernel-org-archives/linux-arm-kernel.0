From: christopher.lee.bostic@gmail.com (Christopher Bostic)
Date: Thu, 8 Dec 2016 16:49:06 -0600
Subject: [PATCH 04/16] drivers/fsi: Add fsi master definition
In-Reply-To: <20161207090610.GB14742@kroah.com>
References: <1481076574-54711-1-git-send-email-christopher.lee.bostic@gmail.com>
 <20161207090610.GB14742@kroah.com>
Message-ID: <CAA0LjjUOuQXW_pJ0yM=vtKKS09Y-oALUvhF9KPDzx0GF+Xkmew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 7, 2016 at 3:06 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Tue, Dec 06, 2016 at 08:09:30PM -0600, Chris Bostic wrote:
>> From: Jeremy Kerr <jk@ozlabs.org>
>>
>> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
>> Signed-off-by: Chris Bostic <cbostic@us.ibm.com>
>> ---
>>  drivers/fsi/fsi-core.c   | 20 ++++++++++++++++++++
>>  drivers/fsi/fsi-master.h | 37 +++++++++++++++++++++++++++++++++++++
>>  2 files changed, 57 insertions(+)
>>  create mode 100644 drivers/fsi/fsi-master.h
>>
>> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
>> index 3d55bd5..ce9428d 100644
>> --- a/drivers/fsi/fsi-core.c
>> +++ b/drivers/fsi/fsi-core.c
>> @@ -17,6 +17,26 @@
>>  #include <linux/fsi.h>
>>  #include <linux/module.h>
>>
>> +#include "fsi-master.h"
>> +
>> +static atomic_t master_idx = ATOMIC_INIT(-1);
>
> You don't really want/need an atomic variable, please use the simple ida
> interface instead.

Greg,

Will make the change to simple ida interface.

Thanks for your feedback,
Chris

>
> thanks,
>
> greg k-h
