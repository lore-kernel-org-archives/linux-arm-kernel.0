From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Wed, 1 Feb 2017 10:52:35 -0800
Subject: [PATCH v3 18/24] media: imx: Add SMFC subdev driver
In-Reply-To: <20170201183918.GP27312@n2100.armlinux.org.uk>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-19-git-send-email-steve_longerbeam@mentor.com>
 <20170201183918.GP27312@n2100.armlinux.org.uk>
Message-ID: <af7f27be-827d-548f-5b26-1e987069a6c0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/01/2017 10:39 AM, Russell King - ARM Linux wrote:
> Hi Steve,
>
> On Fri, Jan 06, 2017 at 06:11:36PM -0800, Steve Longerbeam wrote:
>> +/*
>> + * Min/Max supported width and heights.
>> + *
>> + * We allow planar output from the SMFC, so we have to align
>> + * output width by 16 pixels to meet IDMAC alignment requirements,
>> + * which also means input width must have the same alignment.
>> + */
>> +#define MIN_W       176
>> +#define MIN_H       144
>> +#define MAX_W      8192
>> +#define MAX_H      4096
>> +#define W_ALIGN    4 /* multiple of 16 pixels */
> Does this only apply to planar formats?
>
> I notice Philipp's driver allows 8 pixel alignment.  If it's only for
> planar formats, it ought to determine the alignment based on the
> requested format rather than hard-coding it to the maximum alignment
> of all the supported formats.

yeah, I got lazy/tired there. I will fix this.

Steve
