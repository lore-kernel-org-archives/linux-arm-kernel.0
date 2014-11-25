From: pramod.gurav@smartplayin.com (Pramod Gurav)
Date: Tue, 25 Nov 2014 16:47:07 +0530
Subject: [RFC PATCH] regulator: core: do not disable regulator if boot_on
 is set
In-Reply-To: <20141125110540.GL7712@sirena.org.uk>
References: <1416912803-10772-1-git-send-email-pramod.gurav@smartplayin.com>
 <20141125110540.GL7712@sirena.org.uk>
Message-ID: <54746533.1010408@smartplayin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tuesday 25 November 2014 04:35 PM, Mark Brown wrote:
> On Tue, Nov 25, 2014 at 04:23:23PM +0530, Pramod Gurav wrote:
>> Currently the regulator core disables the regulators which are unused
>> or whose reference count is zero or if they are configured always_on.
> 
> No, it does *not* disable them if they are configured always_on (as the
> code you're modifying shows).

Yes, thats a typo.
> 
>> This change adds a check in this logic to see if a regulator is
>> configured as boot_on and does not disable it if found true.
> 
>> -		if (c && c->always_on)
>> +		if (c && (c->always_on || c->boot_on))
>>  			continue;
> 
> This isn't what boot_on means.  It just means that the regulator is
> expected to be enabled at initial power on, it doesn't mean it needs to
> be enabled all the time.  Otherwise there'd be no point in having a
> separate always_on flag.

Thanks for the comment. :-)
> 
