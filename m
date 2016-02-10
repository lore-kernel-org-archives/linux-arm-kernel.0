From: thomas@schloeter.net (=?utf-8?Q?Thomas_Schl=C3=B6ter?=)
Date: Wed, 10 Feb 2016 19:40:54 +0100
Subject: net: mv643xx: interface does not transmit after some time
In-Reply-To: <312E318A-CAE1-45B1-AB13-EA147B48E315@schloeter.net>
References: <E4F9E0D0-9DA8-4E33-9F89-B49E47F11CE0@schloeter.net>
 <20160206183414.GD17218@lunn.ch> <20160206231935.GA30734@jirafa.cyrius.com>
 <2ACB3A0B-DD51-43C1-A56E-E7C175645554@schloeter.net>
 <20160207203545.GB29107@lunn.ch>
 <A21B89D4-5826-4F97-A1C9-E62E5B724082@schloeter.net>
 <312E318A-CAE1-45B1-AB13-EA147B48E315@schloeter.net>
Message-ID: <A6128DBC-59DB-4231-A08D-B84C1D8C26CC@schloeter.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Am 08.02.2016 um 19:49 schrieb Thomas Schl?ter <thomas@schloeter.net>:
> 
> 
>> Am 07.02.2016 um 22:07 schrieb Thomas Schl?ter <thomas@schloeter.net>:
>> 
>> Am 07.02.2016 um 21:35 schrieb Andrew Lunn <andrew@lunn.ch>:
>>> 
>>>>> FWIW, we had a similar bug report in Debian recently:
>>>>> https://lists.debian.org/debian-arm/2016/01/msg00098.html
>>> 
>>> Hi Thomas
>>> 
>>> I this thread, Ian Campbell mentions a patch. Please could you try
>>> that patch and see if it fixes your problem.
>>> 
>>> Thanks
>>> 	Andrew
>> 
>> Hi Andrew,
>> 
>> I just applied the patch and the NAS is now running it. I?ll try to crash it tonight and keep you informed whether it worked.
>> 
>> Thanks
>> 	Thomas
> 
> Hi Andrew,
> 
> the patch did not fix the problem. After 1.2 GiB RX and 950 MiB TX, the interface crashed again.
> 
> Now I switched off RX/TX offload just to make sure we are talking about the same problem. If we are, the interface should be stable without offload, right?
> 
> 	Thomas

Okay, so I have installed ethtool and switched off all offload features available. Now the NAS is running rock solid for two days. I backed up my Mac using Time Machine / netatalk (450 GiB transferred) and some Linux machines via NFS (100 GiB total) without a problem.

How much code is used for mv643xx offload functionality?
Is it possible to debug things in the driver and figure out what happens during the crash?
Is the hardware offload interface proprietary or reverse engineered or is it a well known API that can be analyzed?

	Thomas
