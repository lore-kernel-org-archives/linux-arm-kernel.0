From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 15 Aug 2013 10:44:26 +0530
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Trustzone-based security
 solution for ARM Linux
In-Reply-To: <20130815042812.GA8968@kroah.com>
References: <CAGsJ_4xnivwNW_Pvhv7Jg62a94d5FChwqEwnNX3Miqd5fAxNHA@mail.gmail.com>
 <20130815042812.GA8968@kroah.com>
Message-ID: <CABb+yY1YKGkAeb-8GbadUoV5g54iCdrYGnD_VSpaNmtfXXhpyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 9:58 AM, Greg KH <greg@kroah.com> wrote:
> On Thu, Aug 15, 2013 at 11:44:30AM +0800, Barry Song wrote:
>> For the moment, there is strong markting requirement from
>> IVI(In-Vehicle Infotainment) or mobile to use ARM Trustzone. We take
>> IVI as an example, Auto requires security enviorment to access CAN bus
>> and other car busses. Auto requires security enviorment to show
>> rearview/surround view from cameras and play alert audio. on the other
>> hand, IVI system is generically working as a video streaming sink and
>> HDMI sink instead of a source. To support HDCP and widevine, we need
>> to make sure private keys and video buffers are only visible to
>> security mode. With CAN stack, video playback backend and more tasks,
>> generically it requires a multi-task RTOS running in security mode
>> parallel with Linux in non-security mode.
>>
>> Linux is a generic purpose OS with UI and all kinds of software, but
>> we need to make sure even the Linux is ROOTed, RTOS in security mode
>> is still active. We are able to find some opensource projects like
>> SafeG[1], Multivisor[2], SierraVisor[3], but it turns out that ARM
>> Linux has no rich support for this kind of architecture:
>> 1. hypervisor running in monitor mode
>> 2. RTOS running in security mode
>> 3. Linux running in non-security mode
>
> "Linux" is just a kernel, not a whole operating system :)
>
> Anyway, why can't Linux be the RTOS kernel as well?  What are the
> requirements for that kernel that Linux does not currently meet?
>
Yes, in fact at least during development Linux usually runs in Secure mode.
Ideally I would love to see 2 instances of Linux running - one in
NonSecure mode and another in Secure mode, getting capabilities via 2
corresponding DTBs reflecting the h/w partitioning done by the TZ.

>
>> 3. as some CPU time is stolen by security mode, so the scheduler need
>> to get this for load balance
>
> Does the kernel know this time is gone?  Or is it not aware of it (like
> MSIs on x86?)
>
The TrustedOS could share time on the same cpu as the UnTrustedOS or
be assigned a dedicated cpu on an MP.

cheers.
-jassi
