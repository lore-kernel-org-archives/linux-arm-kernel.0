From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Mon, 15 Feb 2016 15:57:33 +0300
Subject: [PATCH v2 3/9] ACPI: introduce acpi_table_parse2()
In-Reply-To: <CAJZ5v0ji3rR3HkC7BjygkqXxOrEn3qSKA42i1Rj9tBqZ71Dh+w@mail.gmail.com>
References: <1455299022-11641-1-git-send-email-aleksey.makarov@linaro.org>
 <1455299022-11641-4-git-send-email-aleksey.makarov@linaro.org>
 <20160212185130.GA10095@kroah.com>
 <CAJZ5v0ji3rR3HkC7BjygkqXxOrEn3qSKA42i1Rj9tBqZ71Dh+w@mail.gmail.com>
Message-ID: <56C1CB3D.6070906@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael, 

Thank you for review.

On 02/13/2016 02:08 AM, Rafael J. Wysocki wrote:
> On Fri, Feb 12, 2016 at 7:51 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> On Fri, Feb 12, 2016 at 08:43:34PM +0300, Aleksey Makarov wrote:
>>> The function acpi_table_parse() has some problems:
>>> 1 It can be called only from __init code
>>> 2 It does not pass any data to the handler
>>> 3 It just throws out the value returned from the handler
>>>
>>> These issues are addressed in this patch
>>
>> Why not just fix acpi_table_parse(), like you have, and not add a new
>> API call with a "2" at the end of it.  That seems crazy to try to
>> maintain that level of apis.
>>
>> But I'm not the acpi maintainer(s), so it's their call...
> 
> The ACPI maintainer agrees.

I see. 

How would you prefer it to be fixed:

1. Change the signature/implementation of acpi_table_parse(). 
CON: It would require extensive changes through all the kernel,
which I am not sure I will be able to test (but these changes are
just adding an unused arg to the handler + checking that the 
return value is consistent)

OR

2. Have a local implementation of the function like acpi_table_parse2()
CON: A bit of code duplication.

Thank you
Aleksey Makarov
