From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 10 Nov 2010 08:26:13 -0800
Subject: [PATCH v3 02/13] OMAP: DMA: Introduce errata handling feature
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A7CBE@dbde02.ent.ti.com>
	(Manjunath Kondaiah G.'s message of "Wed, 10 Nov 2010 19:32:03 +0530")
References: <1288099513-1854-1-git-send-email-manjugk@ti.com>
	<1288099513-1854-3-git-send-email-manjugk@ti.com>
	<87sjzakuxp.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DC1A7CBE@dbde02.ent.ti.com>
Message-ID: <87hbfpcfh6.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

[...]

>> > +	if (omap_type() == OMAP3430_REV_ES1_0)
>> > +		SET_DMA_ERRATA(DMA_ERRATA_i88);
>> > +
>> > +	/*
>> > +	 * Errata 3.2/3.3: sometimes 0 is returned if CSAC/CDAC is
>> 
>> This doesn't look like a unique errata identifier.  Chapter 3 
>> is usually
>> the 'Cautions' section, and I don't listed in either the 34xx (v5.9),
>> 36xx (v1.3) or 44xx (v1.3) errata docs under this number, and 
>> don't see
>> that number in either of the 24xx errata docs either.   
>> Please clarify.
>
> Even I tried to find this info from errata docs prior to migrating
> all errata's to generic errata handling. This code was exising earlier,
> hence I retained it "as is", no documentation exists for this errata.
>

Hmm, OK.  

According to the code, it seems to affect every IP execpt 1510, yet it's
not documented in any of the errata docs.  

I wonder what happens if it is removed?

Kevin
