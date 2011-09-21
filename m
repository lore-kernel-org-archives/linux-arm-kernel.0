From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 21 Sep 2011 08:57:46 -0600
Subject: [PATCH] ARM: vexpress: initial device tree support
In-Reply-To: <4E79E588.6010703@gmail.com>
References: <1316596786-2539-1-git-send-email-dave.martin@linaro.org>
	<4E79E588.6010703@gmail.com>
Message-ID: <CACxGe6sTYYXbpXvPb4C+y4JX0eRxLvwjbFycXA8Mjc-XWS1QUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2011 at 7:24 AM, Rob Herring <robherring2@gmail.com> wrote:
> On 09/21/2011 04:19 AM, Dave Martin wrote:
>> ? ? ? * arm,amba-bus -- widely used by other boards and patchsets, but
>> ? ? ? ? seems not to be documented.
>>
>
> This should be dropped. There's not really any bus component to an amba
> bus. All the probing info is within the primecell peripherals.

No, if it is an AMBA bus, then it is entirely appropriate to declare
it as an amba bus, but to also be compatible with "simple-bus".  In
fact, it would be better to use a compatible string that specifies the
specific implementation of AMBA bus since there are several versions
of the spec.

Don't let Linux's current implementation detail derail what is
considered good practice.

g.
