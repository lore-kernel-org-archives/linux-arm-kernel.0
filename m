From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 18 Apr 2013 21:40:43 +0400
Subject: [PATCH 1/8] ARM: shmobile:Marzen: move USB EHCI, OHCI, and PHY
 devices to R8A7779 code
In-Reply-To: <20130418154425.GZ14496@n2100.arm.linux.org.uk>
References: <201304050257.00799.sergei.shtylyov@cogentembedded.com>
 <20130418154425.GZ14496@n2100.arm.linux.org.uk>
Message-ID: <5170301B.3030306@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 18-04-2013 19:44, Russell King - ARM Linux wrote:

>> +/* USB PHY */
>> +static struct resource usb_phy_resources[] = {
>> +	[0] = {
>> +		.start		= 0xffe70000,
>> +		.end		= 0xffe70900 - 1,
>> +		.flags		= IORESOURCE_MEM,
>> +	},
>> +	[1] = {
>> +		.start		= 0xfff70000,
>> +		.end		= 0xfff70900 - 1,
>> +		.flags		= IORESOURCE_MEM,
>> +	},

> Please consider using the macros for these initialisers.

    I'm just moving the code as is here. The destination file still uses old 
style initializers, and probably needs the wholesale conversion patch in the 
future.

WBR, Sergei
