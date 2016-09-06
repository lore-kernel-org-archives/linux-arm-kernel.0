From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 6 Sep 2016 10:48:19 -0700
Subject: [PATCH v3 10/22] usb: chipidea: Consolidate extcon notifiers
In-Reply-To: <20160905023935.GA24593@b29397-desktop>
References: <20160901004036.23936-1-stephen.boyd@linaro.org>
 <20160901004036.23936-11-stephen.boyd@linaro.org>
 <20160902031704.GC16876@shlinux2>
 <CAJOFmgwcc95R8n9DGw0Er4icCMnd=Ku-J0Q7cMEOK212oUs62g@mail.gmail.com>
 <20160905023935.GA24593@b29397-desktop>
Message-ID: <CAJOFmgxWPU1-ugB8+Nr1KDBz0xX1-WaeYVCj6hxEq9UU14Y4Hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 4, 2016 at 7:39 PM, Peter Chen <hzpeterchen@gmail.com> wrote:
> On Fri, Sep 02, 2016 at 06:03:06PM -0700, Stephen Boyd wrote:
>> On Thu, Sep 1, 2016 at 8:17 PM, Peter Chen <hzpeterchen@gmail.com> wrote:
>> > On Wed, Aug 31, 2016 at 05:40:24PM -0700, Stephen Boyd wrote:
>> >>
>> >>
>> >>               if (cable->state)
>> >> -                     val |= OTGSC_ID;
>> >> +                     val &= ~OTGSC_ID; /* A device */
>> >>               else
>> >> -                     val &= ~OTGSC_ID;
>> >> +                     val |= OTGSC_ID; /* B device */
>
> One more comment, would you change the comment to "host" and "device"?
> Unless we are supporting OTG-compliance device, otherwise, we should
> not mention "A" or "B" for USB device.
>

Done
