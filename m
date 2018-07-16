From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 16 Jul 2018 09:56:46 +0100
Subject: [PATCH v4 08/18] net: davinci_emac: potentially get the MAC
 address from MTD
In-Reply-To: <d7f03763-982f-5e3e-d0ad-54e024b10f97@ti.com>
References: <20180629094039.7543-1-brgl@bgdev.pl>
 <20180629094039.7543-9-brgl@bgdev.pl>
 <03b77e24-9ab9-fa01-2387-9de0408a9942@gmail.com>
 <20180704070919.GA14051@lenoch>
 <CAMRc=McOYG9=naT2=4c4hnhJwxcqBCATEZOGXXv9u9zuvXyDXw@mail.gmail.com>
 <c0ffc590-8064-3b02-9b5c-fcc24628d390@ti.com>
 <CAMRc=McO8H9Aw8a7h318a=hJjKBOgeC+9_hreBnOY3Tc3Fh7sg@mail.gmail.com>
 <d7f03763-982f-5e3e-d0ad-54e024b10f97@ti.com>
Message-ID: <a70aebb0-408c-c61f-897a-227114888585@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/07/18 09:50, Sekhar Nori wrote:
> On Friday 13 July 2018 11:30 PM, Bartosz Golaszewski wrote:
> 
>> We're getting close to rc5 so I'd like to make a case for this series again.
>>
>> I understand that there's more to do than just the changes introduced
>> here, but we shouldn't try to fix several problems in many different
>> places at once. There's just too many moving pieces. I'd rather start
>> merging small improvements right away.
>>
>> The idea behind this series is to remove (almost) all users of
>> at24_platform_data. The davinci_emac patches are there only because we
>> need to remove some MAC adress reading stuff from the board files.
>> Having this code there and calling it back from EEPROM/MTD drivers is
>> already wrong and we should work towards using nvmem for that anyway.
>>
>> Currently for MTD the nvmem support series seems to be dead and it's
>> going to take some time before anything gets upstream.
>>
>> So I'd like to again ask you to consider picking up the patches from
>> this series to your respective trees or at the very least: I'd like to
>> ask Srinivas to pick up the nvmem patches and Sekhar to take the
>> first, non-controversial batch of davinci platform changes so that
>> we'll have less code to carry for the next release.
> 
> I think those are patches 3-7. I can take those if I get an immutable
> commit over v4.18-rc1 from Srinivas with patches 1 & 2 applied.
nvmem patches go via Greg KH char-misc tree, if it makes things easy I 
can provide Ack on nvmem patches, so that you can take these patches via 
your tree?

Let me know.

--srini
> 
> Thanks,
> Sekhar
> 
