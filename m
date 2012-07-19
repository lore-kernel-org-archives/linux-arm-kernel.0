From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Jul 2012 12:28:48 +0000
Subject: [PATCH 1/1] Add Wondermedia Technologies (wmt) to
 docs/devicetree/vendor-bindings.txt
In-Reply-To: <76F764B079F92A4E843589C893D0A022C3811BFD@SERVER.prisktech.co.nz>
References: <76F764B079F92A4E843589C893D0A022C380F1D4@SERVER.prisktech.co.nz>
 <201207191116.27273.arnd@arndb.de>
 <76F764B079F92A4E843589C893D0A022C3811BFD@SERVER.prisktech.co.nz>
Message-ID: <201207191228.48809.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 July 2012, Tony Prisk wrote:
> I have no issue with that.
> 
> I am mainly concerned with the Wondermedia products at the moment.
> 
> Adding device tree support for WM8505 (and WM8650) is my main goal as the WM8650
> currently isn't supported and trying to get another board file added seems unlikely with
> everything moving to device tree. The VT8500 requires additional/different patches and
> as I don't have a vt8500 I can't test them.
> 
> It does raise the question of applying 'wmt, prizm-pmc' to the vt8500 though. While it's
> fine for the restart patch I submitted, the vt8500 registers are the same but the bit-fields
> are different and therefore not entirely compatible with 'prizm-pmc'.
> When it comes to other PMC-related features, in particular the clocks, the VT8500 is quite
> different in its bit-fields.
> 
> The vt8500 isn't technically in the Prizm family, as that is Wondermedia's name for the SoC's.
> 

My point is that for each peripheral, we should decide separately what the
most descriptive name for it is. If the pmc is common for all wmt prizm
chips, then using the "wmt,prizm-pmc" string makes sense, and vt8500
can use "via,vt8500-pmc" or something like that.

However for stuff like the rtc that appears to be unchanged between them,
I would use the compatible string of the oldest known chip using it,
so even a wmt8650 should just claim compatibility with vt8500 there and
list both "wmt,wm8650-rtc" and "via,vt8500-rtc" there.

	Arnd
