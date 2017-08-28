From: stefan.mavrodiev@gmail.com (Stefan Mavrodiev)
Date: Mon, 28 Aug 2017 09:07:02 +0300
Subject: [PATCH 1/3] ARM: dts: sun7i: Fix A20-OLinuXino-MICRO dts for use
 with LAN8710
In-Reply-To: <20170825134844.7vz3pdloagmgegcw@flea.lan>
References: <20170822114313.9038-1-stefan@olimex.com>
 <20170822114313.9038-2-stefan@olimex.com>
 <20170822203157.mvnx224l546vamah@flea.home>
 <CAK17dA+xsYfBWZi=sE+aNchEBzwoXXisKr=C9O5vN-O0x4vvww@mail.gmail.com>
 <20170823143018.trug6jmuxkoehoou@flea.home>
 <447ade4b-c4ed-5b51-7a43-6972b276e553@gmail.com>
 <20170825134844.7vz3pdloagmgegcw@flea.lan>
Message-ID: <c599c394-db4f-afb6-f11b-f5a684e9e5b7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/25/2017 04:48 PM, Maxime Ripard wrote:
> Hi Stefan,
>
> Please keep all the recipients in Cc.
>
> On Thu, Aug 24, 2017 at 08:24:05AM +0300, Stefan Mavrodiev wrote:
>> On 08/23/2017 05:30 PM, Maxime Ripard wrote:
>>> On Tue, Aug 22, 2017 at 11:58:19PM +0300, Stefan Mavrodiev wrote:
>>>> As I can see, if GMAC is used, this function is GNULL - same as PA14
>>>> and PA9. I don't think that it's controlled by GMAC.
>>> Do you know if in such a case the level is properly asserted?
>> I've checked the level with oscilloscope.
> With the pin function set to GMAC? What was the outcome?

This was strange. Last time I've checked this signal it was toggling. Today I've done
the same - output low. Probably my initial board was broken or something. (Often I use
boards that comes directly from assembly line, before quality testing.)

Anyway, the PHY is working with PA17 set with GMAC function. I'll rework the patch and
resend it later.

>
>> However, I've fixed the patch replacing GMAC node with EMAC and
>> setting PA17 as "emac" function. This way the PHY is working
>> correctly. Since it's 100T can I do this or there is particular
>> reason for using GMAC over EMAC?
> In general, the GMAC driver has more features and is better maintained
> than the EMAC one, so even it wouldn't change much in our case, it'd
> be better to stick to the GMAC.
>
> Maxime
>
Thank you for the help.

Stefan Mavrodiev
Olimex Ltd.
