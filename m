From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 13:06:17 +0100
Subject: [PATCH v3 06/13] ARM: dts: armada-375: Fixup sa-ram DT warning
In-Reply-To: <20161118095925.770496c3@free-electrons.com> (Thomas Petazzoni's
 message of "Fri, 18 Nov 2016 09:59:25 +0100")
References: <20161117230830.31047-1-gregory.clement@free-electrons.com>
 <20161117230830.31047-7-gregory.clement@free-electrons.com>
 <20161118095925.770496c3@free-electrons.com>
Message-ID: <8737ipat6u.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On ven., nov. 18 2016, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Hello,
>
> On Fri, 18 Nov 2016 00:08:23 +0100, Gregory CLEMENT wrote:
>
>> -		crypto_sram0: sa-sram0 {
>> +		/* The following unit addresses (for sa-sram) are composed of
>> +		 * the target value (bit [40-47]), attributes value (bits
>> +		 * [32-39], and the address value in the window memory: [0-31].
>> +		 */
>
> The "address value in the window memory" part doesn't make a lot of
> sense. Maybe:
>
> "The following unit addresses are composed of the window target ID
> (bits 40-47), the window target attributes (bits 32-39) and the offset
> inside the window."

I'm fine with it

>
> Also, the comment formatting is not compliant with the coding style,
> should be:
>
>  /*
>   * ...
>   * ...
>   */
>

Hum yes I need to teach emacs how to properly format the comments.

> But do we really want this comment above each node? Couldn't we instead
> add this explanation in the mvebu-mbus.txt DT binding?

We could but I fear that nobody will read it.

Indeed if you know that in order to understand the unit address, you will
have to have a look an the binding of the mvebu-mbus, then it means that
you already are an expert and actually you barely need to read it!

In order to have less change we could at least put it near the MBUS_ID
macro and if the mvebu-mbus.txt DT binding too.


Gregory
>
> Best regards,
>
> Thomas
> -- 
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
