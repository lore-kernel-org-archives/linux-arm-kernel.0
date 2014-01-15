From: grant.likely@linaro.org (Grant Likely)
Date: Wed, 15 Jan 2014 14:56:52 +0000
Subject: [RFC PATCH 1/1] of/irq: create interrupts-extended-2 property
In-Reply-To: <20140115121750.GE25824@e106331-lin.cambridge.arm.com>
References: <1389786445-10598-1-git-send-email-plagnioj@jcrosoft.com>
 <20140115121750.GE25824@e106331-lin.cambridge.arm.com>
Message-ID: <CACxGe6tpF146rJFw915=Y1WxWCZ=XkeDrHvyBsY=5b_Yw=Rivg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 15, 2014 at 12:17 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Jan 15, 2014 at 11:47:25AM +0000, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> The new interrupts-extended property, which reuses the phandle+arguments
>> pattern used by GPIOs and other core bindings, still have some issue.
>>
>> If an SoC have already specifiy interrupt and a board want to add specific
>> interrupt such as GPIO (which can be optionnal) be need to re-define
>> interrupts-extended. So allow to have an optionnale interrupts-extended-2
>> property.
>>
>
> NAK.
>
> This is a hack that works around a dts organisation issue. This is _not_
> a binding or parsing issue.
>
> Properties can be overridden - just describe all of the interrupts in
> the final dts file.

Agreed. The current binding handles the case of multiple interrupts just fine.

g.
