From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 04 Dec 2014 06:26:50 -0800
Subject: [PATCH v7 08/11] arm/arm64: Unexport restart handlers
In-Reply-To: <CAMuHMdVqCa+m1oMkuRHcTZKw2CWNHJVotWBwfTnfBNT11UPEjw@mail.gmail.com>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net>	<1408495538-27480-9-git-send-email-linux@roeck-us.net>
 <CAMuHMdVqCa+m1oMkuRHcTZKw2CWNHJVotWBwfTnfBNT11UPEjw@mail.gmail.com>
Message-ID: <54806F2A.7070107@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/2014 05:36 AM, Geert Uytterhoeven wrote:
> Hi G?nther,
>
> On Wed, Aug 20, 2014 at 2:45 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>> Implementing a restart handler in a module don't make sense
>> as there would be no guarantee that the module is loaded when
>> a restart is needed. Unexport arm_pm_restart to ensure that
>> no one gets the idea to do it anyway.
>
> Why not? I was just going to do that, but I got greeted by:
>

Because you should register a restart handler instead, like the other
drivers in the same directory now do.

> ERROR: "arm_pm_restart" [drivers/power/reset/rmobile-reset.ko] undefined!
>
> So now we have to make sure all reset drivers for a zillion different
> hardware devices are builtin, and can't be modular?
>
No. All those drivers need to do is to register a restart handler using
the API provided in the patch series.

Ultimately all restart handlers should do that and arm_pm_restart should
go away entirely. That was the point of the patch series.

Guenter
