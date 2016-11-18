From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 18 Nov 2016 09:59:25 +0100
Subject: [PATCH v3 06/13] ARM: dts: armada-375: Fixup sa-ram DT warning
In-Reply-To: <20161117230830.31047-7-gregory.clement@free-electrons.com>
References: <20161117230830.31047-1-gregory.clement@free-electrons.com>
 <20161117230830.31047-7-gregory.clement@free-electrons.com>
Message-ID: <20161118095925.770496c3@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 18 Nov 2016 00:08:23 +0100, Gregory CLEMENT wrote:

> -		crypto_sram0: sa-sram0 {
> +		/* The following unit addresses (for sa-sram) are composed of
> +		 * the target value (bit [40-47]), attributes value (bits
> +		 * [32-39], and the address value in the window memory: [0-31].
> +		 */

The "address value in the window memory" part doesn't make a lot of
sense. Maybe:

"The following unit addresses are composed of the window target ID
(bits 40-47), the window target attributes (bits 32-39) and the offset
inside the window."

Also, the comment formatting is not compliant with the coding style,
should be:

 /*
  * ...
  * ...
  */

But do we really want this comment above each node? Couldn't we instead
add this explanation in the mvebu-mbus.txt DT binding?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
