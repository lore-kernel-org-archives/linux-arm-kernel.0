From: cory.tusar@pid1solutions.com (Cory Tusar)
Date: Thu, 25 Feb 2016 11:24:43 -0500
Subject: [PATCH] ARM: dts: vf610-zii-dev: Add ZII development board.
In-Reply-To: <c67c93683d9440bd050386df0e200881@agner.ch>
References: <1456084314-9871-1-git-send-email-andrew@lunn.ch>
 <c67c93683d9440bd050386df0e200881@agner.ch>
Message-ID: <56CF2ACB.7080301@pid1solutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/23/2016 02:36 PM, Stefan Agner wrote:
> Hi Andrew,
> 
> Some comments below:
> 
> On 2016-02-21 11:51, Andrew Lunn wrote:
>> From: Cory Tusar <cory.tusar@pid1solutions.com>
>>
>> This commit adds support for Rev. B of a Zodiac Inflight Innovations
>> development board, mainly intended for DSA and ARINC 429 development
>> work.
>>
>> Signed-off-by: Cory Tusar <cory.tusar@pid1solutions.com>
>> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

[snip]

>> +&L2 {
>> +	arm,data-latency = <2 1 2>;
>> +	arm,tag-latency = <3 2 3>;
>> +};
> 
> Are you sure about that?
> 
> With 9c17190595 ("ARM: dts: vf610: use reset values for L2 cache
> latencies") we have reasonable values in the base device tree
> vf610.dtsi, I think therefor this is not necessary anymore, even if you
> use 500MHz as CPU clock.

Hi Stefan,

We'd had some pretty serious instability on our platform with the older
values (prior to the commit mentioned above).  I recall seeing that
change go in, and reviewed the discussion on Freescale's support forum,
but left things as they were pending official comment from Freescale.

"If it isn't broken...."

We can certainly try the new defaults and see if it crops up again.

FWIW, yes, we're running at 500 MHz.

Best regards,
- -Cory


- -- 
Cory Tusar
Principal
PID 1 Solutions, Inc.


"There are two ways of constructing a software design.  One way is to
 make it so simple that there are obviously no deficiencies, and the
 other way is to make it so complicated that there are no obvious
 deficiencies."  --Sir Charles Anthony Richard Hoare

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlbPKssACgkQHT1tsfGwHJ8acwCbB0/2AZrfGzRlIrr01igdDbGH
Q7QAoKtZcm0eyQNQxO3IlZUA6dSY+GEf
=sdAe
-----END PGP SIGNATURE-----
