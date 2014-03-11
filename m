From: robherring2@gmail.com (Rob Herring)
Date: Tue, 11 Mar 2014 10:14:23 -0500
Subject: [PATCH 2/3] soc: keystone: add QMSS driver
In-Reply-To: <5EE98053-31B8-4679-AAE2-4F026C61D1D4@codeaurora.org>
References: <1393629520-12713-1-git-send-email-santosh.shilimkar@ti.com>
 <1393629520-12713-3-git-send-email-santosh.shilimkar@ti.com>
 <CAL_Jsq+O660oV9FtthG3gTkVOhL0ku-UHSrkt-ROauu1iNpbaA@mail.gmail.com>
 <531E2C55.70702@ti.com>
 <5EE98053-31B8-4679-AAE2-4F026C61D1D4@codeaurora.org>
Message-ID: <CAL_JsqLKoZd4L2jjzD5Z8fFO9Cx1SH7cfE-PnEY_Vx2Sx0FRYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 11, 2014 at 9:04 AM, Kumar Gala <galak@codeaurora.org> wrote:
>
> On Mar 10, 2014, at 4:19 PM, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
>
>>>> +  -- reg-names         : Names for the above register regions. The name to be
>>>> +                         used is as follows:
>>>> +                         - "config" : Queue configuration region.
>>>> +                         - "status" : Queue status RAM.
>>>> +                         - "region" : Descriptor memory setup region.
>>>> +                         - "push"   : Queue Management/Queue Proxy region.
>>>> +                         - "pop"    : Queue Management/Queue Proxy region.
>>>> +                         - "peek"   : Queue Peek region.
>>>
>>> reg-names should be optional. Also you have the order different from
>>> reg. Be consistent as to what is the correct order.
>>>
>> We thought of using reg-names to remove the ordering to index
>> the regs. So if we make the reg-names optional, then indexing
>> by order will be used. We can do that.
>
> We keep having this conversation, why does reg-names need to be optional for new bindings?

Because order is a fundamental part of the reg and interrupts
properties and has been since the beginning of DT. Adding auxiliary
data does not change that. We just discussed this in our weekly DT
meeting[1]. In many cases defining the order is not a burden. For the
exceptions, the binding needs to spell out why the order can't be
fixed.

Rob

[1] http://irclogs.linaro.org/meeting-logs/devicetree/2014/devicetree.2014-03-11-14.09.log.html
