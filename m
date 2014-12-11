From: marcel@holtmann.org (Marcel Holtmann)
Date: Thu, 11 Dec 2014 12:18:44 +0100
Subject: default enable sparse __CHECK_ENDIAN__ (was: Re: [PATCH v7 2/3]
 net: Add Keystone NetCP ethernet driver)
In-Reply-To: <1418267099.18092.28.camel@perches.com>
References: <1417556503-22290-3-git-send-email-m-karicheri2@ti.com>
 <20141209.131053.2026868499542642866.davem@davemloft.net>
 <5488BB96.9070609@ti.com>
 <20141210.204110.618599360537141819.davem@davemloft.net>
 <1418267099.18092.28.camel@perches.com>
Message-ID: <479338B3-A0C0-4443-9C44-E03421F0679C@holtmann.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,

>>> Are you referring to the static code analyser sparse that is invoked
>>> through?
>> You have to explicitly enable endian checking, it's not on by
>> default.
> 
> There don't seem to be thousands of warnings anymore.
> 
> Maybe it's time to default enable it when using C=?
> 
> from: Documentation/sparse.txt:
> 
> The optional make variable CF can be used to pass arguments to sparse.  The
> build system passes -Wbitwise to sparse automatically.  To perform endianness
> checks, you may define __CHECK_ENDIAN__:
> 
>        make C=2 CF="-D__CHECK_ENDIAN__"
> 
> These checks are disabled by default as they generate a host of warnings.

actually a few subsystems use this in their Makefile:

	subdir-ccflags-y += -D__CHECK_ENDIAN__

We could start with that to enable endian checks by default in various places.

Regards

Marcel
