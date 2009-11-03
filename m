From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 03 Nov 2009 15:42:16 +0100
Subject: [RFC PATCH] atmel_lcdfb Kconfig: remove long dependency line
In-Reply-To: <20090625084631.GA7985@n2100.arm.linux.org.uk>
References: <4A40D695.5000302@atmel.com>
	<1245767456-6434-1-git-send-email-nicolas.ferre@atmel.com>
	<20090623153556.0e574899@hskinnemoen-d830>
	<4A40E2E6.9060904@atmel.com>
	<20090625084631.GA7985@n2100.arm.linux.org.uk>
Message-ID: <4AF04148.8070103@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I come back on this patch as I have a Kconfig cleanup patch series coming.

Russell King - ARM Linux :
> On Tue, Jun 23, 2009 at 04:12:54PM +0200, Nicolas Ferre wrote:
>> Haavard Skinnemoen :
>>> Nicolas Ferre wrote:
>>>> +config ARCH_ATMEL_HAS_FB
>>>> +	bool
>>>> +	depends on FB
>>>> +	default n
>>> What happens when we unconditionally select something which depends on
>>> something else?
>> :-P
>>
>> Experience shows that this configuration is selected.
>>
>> The dependency allows to have a good hierarchy in the configuration tree...
>> Better proposition welcome.
> 
> 1st - no need for 'default n' - you're specifying something that's already
> the default.

Ok.

> 2nd - don't make this symbol depend on anything, and don't use the symbol
> for anything except providing a dependency for FB_ATMEL.  Instead, let
> FB_ATMEL deal with the dependency on FB and ARCH_ATMEL_HAS_FB.

The problem is that if I do not setup the dependency here the menu entry
will not be available at the proper level. In fact I will see the Atmel
LCD entry here:
"Graphics support"
 <*> Support for frame buffer devices  --->
 <*> AT91/AT32 LCD Controller support

instead of here:
"Graphics support"
 ---> "Support for frame buffer devices"
      [..]
      <*> "AT91/AT32 LCD Controller support"
      [..]

So I keep the depend.

> 3rd - ISTR we have a convention for these - 'HAVE_foo' for a configuration
> option named 'foo'.  So it should probably be HAVE_FB_ATMEL.

Ok, changed to HAVE_FB_ATMEL indeed.

Thanks. Best regards,
-- 
Nicolas Ferre
