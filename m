From: robherring2@gmail.com (Rob Herring)
Date: Mon, 28 Apr 2014 13:50:33 -0500
Subject: [PATCH 02/16] ARM: l2c: add platform independent core L2 cache
 initialisation
In-Reply-To: <20140428182312.GR26756@n2100.arm.linux.org.uk>
References: <20140428165631.GM26756@n2100.arm.linux.org.uk>
 <E1WeosP-0002PO-5m@rmk-PC.arm.linux.org.uk>
 <CAL_JsqJDj_JZT_Mo5=Y1NqObX19v7WvuWSrmAZ4UXi9s6-prXA@mail.gmail.com>
 <20140428182312.GR26756@n2100.arm.linux.org.uk>
Message-ID: <CAL_JsqJXQzrNxyLW68nEdu=QNr2FrYEDnT_JUzLcxJXBh2=dNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 1:23 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Apr 28, 2014 at 12:54:58PM -0500, Rob Herring wrote:
>> This function should be a nop if there is no DT node matching, so we
>> don't really need to trigger calling it based on machine_desc values.
>> If we do that, then we can have aux_mask and aux_val values of 0 for
>> both also mean don't do any aux ctrl setup. That would help minimize
>> the machine_desc for many platforms.
>
> Calling it with both set to zero results in the auxiliary control register
> being cleared to zero.  We don't want that to happen.

Right, but we can make the core L2 init code only write aux ctrl if
(aux_val && ~aux_mask). Then you don't have to add the values on a
bunch of platforms.

Rob
