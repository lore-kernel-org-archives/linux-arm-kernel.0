From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 28 May 2014 00:37:36 +0200
Subject: [PATCH 2/2] ARM: dts: mvebu: split SolidRun CuBox into variants
In-Reply-To: <32589428.8iAxtgFCnl@phil>
References: <1401140009-31505-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140527213549.GU8664@titan.lakedaemon.net> <538508A5.2010809@gmail.com>
 <32589428.8iAxtgFCnl@phil>
Message-ID: <538513B0.2020903@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2014 12:24 AM, Heiko St?bner wrote:
> Am Dienstag, 27. Mai 2014, 23:50:29 schrieb Sebastian Hesselbarth:
>> On 05/27/2014 11:35 PM, Jason Cooper wrote:
>>> On Tue, May 27, 2014 at 07:28:09PM +0200, Sebastian Hesselbarth wrote:
>>>> On 05/27/2014 06:11 PM, Jason Cooper wrote:
>>>>> On Mon, May 26, 2014 at 11:33:29PM +0200, Sebastian Hesselbarth wrote:
>>> info.  It may be useful here, but I'd like to hear from the DT
>>> maintainers how they want it used.  eg: most popular first, like you
>>> have it, or oldest first
>>>
>>> dove-cubox-es.dts
>>> +--> dove-cubox.dts
>>
>> In the cubox case, this is not possible. ES has a misrouted
>> card-detection for sdhci, this requires an additional property.
>> There is no way to remove a property once it is written down in
>> any of the files included. But you know about that already.
> 
> dtc knows "/delete-property/" [0], but I may be missing something here.
> 
> [0] https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-August/018169.html

Heiko,

thanks for the link, I must have completely ignored it! Now that I
think about it, it may be very useful for kirkwood-98xsomething.dtsi
that is a special Kirkwood with a bunch of IP removed (but only some
boards). That way we could consolidate the common SoCs and use
/delete-node/ for the special case SoC.

Anyway, for CuBox ES, I either prefer the v2 approach just send - or
have a cubox-common.dtsi with two board dts for 1G and ES each. We use
this structure a lot and Andrew showed it even works for up to 5 or 10
different variants.

Sebastian
