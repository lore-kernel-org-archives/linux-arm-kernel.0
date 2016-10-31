From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Mon, 31 Oct 2016 23:04:18 +0100
Subject: [PATCH] ARM: BCM5301X: Add back handler ignoring external
 imprecise aborts
In-Reply-To: <18db27c7-1055-ff3c-0b0b-eeeaf5f3f5e0@gmail.com>
References: <20161029111229.26875-1-zajec5@gmail.com>
 <a491509e-5cfc-fc7d-0011-dfcab3c884ea@broadcom.com>
 <6e252703-0010-83ae-fa14-57352add007a@hauke-m.de>
 <fb2c36cb-6f85-1a6d-160a-c50e22d6c46b@gmail.com>
 <dcb21fe4-672f-4545-5b47-d764f390e741@broadcom.com>
 <18db27c7-1055-ff3c-0b0b-eeeaf5f3f5e0@gmail.com>
Message-ID: <CACna6rxZHY53Tj0yr_TtNAEmibq=3=Ea7DexqDFiSiY_NXJebg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 October 2016 at 22:56, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 10/31/2016 02:46 PM, Scott Branden wrote:
>> A problem with reintroducing this change is that all imprecise data
>> aborts are ignored, not just PCI.  So if you don't actually use PCI in
>> your system and want to debug other aborts you are unable to.  I don't
>> know if we care about such situation.
>
> Considering that any abort is pretty much fatal, the options are:
>
> - update the freaking bootloader to a version where there are no such
> aborts generated, not an option on consumer devices, unclear which
> version (if any) fixes that
>
> - fixups the aborts externally, via a boot wrapper, which is going to
> take some time to develop, causes additional burden on the distributors
> to provide instructions/build images on how to do it

In practice updating bootloader is not possible (as you noticed) but I
don't think it's even possible to fix this problem at bootloader /
extra loader level. If this was a matter of hardware setup, we could
handle it in kernel as well I believe. Ray actually verified it's
controller limitation on Northstar platform.
It sounds a bit like you're thinking about MMU and Dcache Northstar
problem when writing that e-mail.


> - fixups the aborts in the kernel, irrespective of where they come from,
> simple and easy
>
> - fixups the aborts in the kernel, look where they come from, by using
> some bit of magic, looking at PCIe registers and whatnot (provided that
> is even possible), not too hard, but can take a while, and is error prone
>
> I can certainly advocate that option 3 is the one that gives a working
> device, and this is what matters from a distribution perspective like
> LEDE/OpenWrt.

-- 
Rafa?
