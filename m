From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Fri, 3 Mar 2017 18:17:47 +0100
Subject: No output on console despite ignore_loglevel earlyprintk
In-Reply-To: <0e7d14d5-d087-cba3-1792-fb0abf1142ef@sigmadesigns.com>
References: <6d16a384-1a4c-bf27-fd81-ea3caf3de6b0@sigmadesigns.com>
 <6cc48f5c-b028-2bb7-c09b-92c36554fe07@suse.de>
 <0e7d14d5-d087-cba3-1792-fb0abf1142ef@sigmadesigns.com>
Message-ID: <3fc43a98-71b1-03df-6809-726230dc27d1@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 03.03.2017 um 18:07 schrieb Marc Gonzalez:
> On 03/03/2017 17:59, Andreas F?rber wrote:
>> Am 03.03.2017 um 17:42 schrieb Marc Gonzalez:
>>> 	chosen {
>>> 		stdout-path = "serial:115200n8";
>>> 	};
>>>
>>> Isn't stdout-path = "serial:115200n8" supposed to be equivalent to
>>> console=ttyS0,115200 ?
>>
>> First of all, that should probably be serial0, and it needs to be
>> defined as an alias. In my case that's a given.
> 
> My DT root node contains
> 
> 	aliases {
> 		serial = &uart;
> 		eth0 = &eth0;
> 	};
> 
> Should I be using serial0 everywhere?
> (I thought I could call it "foo", if I wanted.)

Most serial drivers call of_alias_get_id() to retrieve the index - feel
free to add some debug output to see whether "serial" and "serial0"
behave the same, I haven't tested - literal "foo" will definitely behave
differently since the drivers check for "serial".

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
