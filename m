From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Fri, 2 Sep 2016 18:03:06 -0700
Subject: [PATCH v3 10/22] usb: chipidea: Consolidate extcon notifiers
In-Reply-To: <20160902031704.GC16876@shlinux2>
References: <20160901004036.23936-1-stephen.boyd@linaro.org>
 <20160901004036.23936-11-stephen.boyd@linaro.org>
 <20160902031704.GC16876@shlinux2>
Message-ID: <CAJOFmgwcc95R8n9DGw0Er4icCMnd=Ku-J0Q7cMEOK212oUs62g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 1, 2016 at 8:17 PM, Peter Chen <hzpeterchen@gmail.com> wrote:
> On Wed, Aug 31, 2016 at 05:40:24PM -0700, Stephen Boyd wrote:
>>
>>
>>               if (cable->state)
>> -                     val |= OTGSC_ID;
>> +                     val &= ~OTGSC_ID; /* A device */
>>               else
>> -                     val &= ~OTGSC_ID;
>> +                     val |= OTGSC_ID; /* B device */
>>
>>               if (cable->enabled)
>>                       val |= OTGSC_IDIE;
>
> /**
>  * struct ci_hdrc_cable - structure for external connector cable state tracking
>  * @state: current state of the line
>
> You may change the name of variable "state" to "connected", per I
> understand, it has changed to the meaning of connected status for your patch.
>

Ok sure.
