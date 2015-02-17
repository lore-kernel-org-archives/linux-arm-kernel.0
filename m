From: arun.ramamurthy@broadcom.com (Arun Ramamurthy)
Date: Tue, 17 Feb 2015 13:05:50 -0800
Subject: [PATCH 1/2] phy: usbphy: Add dt documentation for Broadcom Cygnus
 USB PHY driver
In-Reply-To: <2797126.uqvyZJisPk@wuerfel>
References: <1424200821-16368-1-git-send-email-arun.ramamurthy@broadcom.com>
 <8242260.cl4QTECoeX@wuerfel> <54E39DF1.50409@broadcom.com>
 <2797126.uqvyZJisPk@wuerfel>
Message-ID: <54E3AD2E.8050902@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15-02-17 12:53 PM, Arnd Bergmann wrote:
> On Tuesday 17 February 2015 12:00:49 Arun Ramamurthy wrote:
>> Arnd, I patched the ehci and ohci driver to accept multiple phys so they
>> require different names and cannot both be "usb". That patch was
>> accepted by Alen Stern but I did not update the bindings documentation.
>> I will send out another patch for that. Could we go with the naming
>> scheme of "usb" + "p" + port number or do you have other suggestions?
>
> I don't have a good idea, but I think it would be best if the first
> phy could remain named "usb" for compatibility with the existing binding.
>
The patch was written in a way that all the existing and new drivers can
continue to use "usb" if they are using only one phy so that we remain 
compatible. The names need to be different only if more than one phy is 
specified. In such cases i don't think the first phy should be "usb" as 
it would be confusing to have
	phy-names = "usb","usbp1"
Should I run this by Alan Stern?
> What is the reason for having two phys in your case? Are these
> identical phy devices connected to a single controller or do they
> server different purposes?
>
Yes, we have three identical phys connected to a single host controller 
and one of the phys is also connected to the device controller
> 	Arnd
>
