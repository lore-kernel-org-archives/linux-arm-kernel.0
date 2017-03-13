From: rafal@milecki.pl (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Mon, 13 Mar 2017 20:15:27 +0100
Subject: [PATCH] ARM: dts: BCM5301X: Add support for TP-LINK Archer C5 V2
In-Reply-To: <20170313191416.GB10397@lunn.ch>
References: <20170311121453.18534-1-zajec5@gmail.com>
 <20170312171032.GK15842@lunn.ch>
 <437d898d-b0f4-a4b5-cb51-8ea88ba7a35a@milecki.pl>
 <20170313191416.GB10397@lunn.ch>
Message-ID: <89081716-c0e3-236f-4291-e700dbedbd34@milecki.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2017 08:14 PM, Andrew Lunn wrote:
> On Mon, Mar 13, 2017 at 07:48:26PM +0100, Rafa?? Mi??ecki wrote:
>> On 03/12/2017 06:10 PM, Andrew Lunn wrote:
>>>> +	chosen {
>>>> +		bootargs = "console=ttyS0,115200 earlycon";
>>>
>>> Using bootargs to pass the serial settings has been deprecated for a
>>> while. Please use stdout-path instead.
>>
>> I tried following patch with my SR400ac (I put Archer C5 aside for now).
>
> Hi Rafael
>
> Take a look at for example the bcm911360k.dts
>
>         aliases {
>                 serial0 = &uart3;
>         };
>
>         chosen {
>                 stdout-path = "serial0:115200n8";
>         };
>
> You need an alias to the serial device you want to us, and you should
> list the speed, parity, bits etc.

That was actually my first try (just with s/uart3/uart0) and I got the same problem.
