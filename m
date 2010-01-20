From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 20 Jan 2010 11:59:24 +0100
Subject: [PATCH 1/2] s3cmci: Initialize default platform data no_wprotect
	and no_detect with 1
In-Reply-To: <4B56DE8A.70209@ru.mvista.com>
References: <1263975361-29376-1-git-send-email-lars@metafoo.de>
	<4B56DE8A.70209@ru.mvista.com>
Message-ID: <4B56E20C.3020207@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Sergei Shtylyov wrote:
> Hello.
>
> Lars-Peter Clausen wrote:
>
>> If no platform_data was givin to the device it's going to use it's
>> default
>> platform data struct which has all fields initialized to zero.
>> As a result the driver is going to try to request gpio0 both as
>> write protect
>> and card detect pin. Which of course will fail and makes the driver
>> unusable
>>
>> Previously to the introduction of no_wprotect and no_detect the
>> behavior was
>> to assume that if no platform data was given there is no write
>> protect or card
>> detect pin.
>> This patch restores that behavior.
>>  
>
>   The very idea of the default platform data seems dubious...
>
> WBR, Sergei
Hi

Could you please elaborate a bit more what makes you think so? Cause
with my current knowledge I tend to disagree, but I've you'd given an
argument it might had convinced me otherwise. Or if not, I could have
given you a reason why I tend to disagree. :)

- - Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAktW4gsACgkQBX4mSR26RiM1+QCeIDuvTZUL3lkvZ0eX6i98FRR/
gBsAn3L8Lw1cceaqeN+Fst3l965X01Vh
=x4MP
-----END PGP SIGNATURE-----
