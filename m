From: lho@apm.com (Loc Ho)
Date: Fri, 14 Feb 2014 13:44:08 -0800
Subject: [PATCH v10 0/4] ata: Add APM X-Gene SoC SATA host controller
 support
In-Reply-To: <20140214150322.GB29516@htj.dyndns.org>
References: <CAPw-ZTkbpOEHowGvp-_3DcW1qW0AK_ZbpdS1LESJfhFU-n_Mtw@mail.gmail.com>
 <CAPw-ZTn5c=v+7pbetEjXWpw9i=cG+zdeHPxO1QD0e42uFrKnCg@mail.gmail.com>
 <20140214150322.GB29516@htj.dyndns.org>
Message-ID: <CAPw-ZT=DGKfshpKb2K7+=gXyzbi8r51MeURJDv9d5YgHfE8prw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tejun,

>
> On Thu, Feb 13, 2014 at 03:28:01PM -0800, Loc Ho wrote:
>> 1. There are a number of errata that require workaround. Some can be
>> fixed by adding broken flags while others are better to just wrap
>> around the existent libahci library routines and not overly polluting
>> the libahci routines.
>> 2. There are additional controller programming sequences to configure.
>> 2a. By default, RAM are powered down and require brought out of shutdown.
>> 2b. The controller has an additional corresponding PHY part that needs
>> to be programmed after PHY configuration.
>
> Have you looked at the latest patchset Hans posted?  He added multiple
> PHY support and split up init to three steps so that each platform
> driver can mix and match as they see fit.  Looking at xgene driver,
> sure there are things specific to the driver but there also are
> non-insignificant amount of boilerplate code and that's what I'm
> primarily concerned about.  It may be okay when you have two or three
> drivers duplicating some code but it looks like we could have many
> more and I *really* want to avoid the situation where the same piece
> of code is copied over N times.  In addition, frankly, not many people
> except yourself would care about these drivers once they're merged and
> many of these are gonna be painful to test making later refactoring a
> lot harder.
>

Ok... I will look into Hans' patch again. To be sure that I am looking
at the correct patch, are you referring to this one:

http://www.spinics.net/lists/linux-ide/msg47628.html

-Loc
