From: robherring2@gmail.com (Rob Herring)
Date: Wed, 21 Sep 2011 11:37:54 -0500
Subject: [PATCH] ARM: vexpress: initial device tree support
In-Reply-To: <CACxGe6sTYYXbpXvPb4C+y4JX0eRxLvwjbFycXA8Mjc-XWS1QUA@mail.gmail.com>
References: <1316596786-2539-1-git-send-email-dave.martin@linaro.org>
	<4E79E588.6010703@gmail.com>
	<CACxGe6sTYYXbpXvPb4C+y4JX0eRxLvwjbFycXA8Mjc-XWS1QUA@mail.gmail.com>
Message-ID: <4E7A12E2.9040107@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/21/2011 09:57 AM, Grant Likely wrote:
> On Wed, Sep 21, 2011 at 7:24 AM, Rob Herring <robherring2@gmail.com> wrote:
>> On 09/21/2011 04:19 AM, Dave Martin wrote:
>>>       * arm,amba-bus -- widely used by other boards and patchsets, but
>>>         seems not to be documented.
>>>
>>
>> This should be dropped. There's not really any bus component to an amba
>> bus. All the probing info is within the primecell peripherals.
> 
> No, if it is an AMBA bus, then it is entirely appropriate to declare
> it as an amba bus, but to also be compatible with "simple-bus".  In
> fact, it would be better to use a compatible string that specifies the
> specific implementation of AMBA bus since there are several versions
> of the spec.

And type of AMBA bus as the spec includes AXI, AHB, and APB. None of
which have any sort of programmability or software view.

If this is required, then the policy should be simple-bus should never
be allowed alone as every bus has some underlying type. Seems like
overkill for buses like this.

Rob
